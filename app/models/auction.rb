class Auction < ActiveRecord::Base
  validates_presence_of :brand, :model, :starting_price, :min_increment
  validates :starting_price, :numericality => { :greater_than_or_equal_to => 1 }

  enum status: { running: 0, ended: 1, suspended: 2 }

  has_many :bids
  has_many :bidders, through: :bids

  belongs_to :creator, class_name: 'User' #instead of belongs_to :user, which is not very readable
  belongs_to :winner, class_name: 'User'

  # Scope for all active auctions
  scope :active, -> { where('end_time > ?', Time.now) }
  scope :overdue, -> { where('end_time < ?', Time.now) }

  after_create do
    update_attribute(:current_price, starting_price)
    running! # set status to running
  end

  def time_left
    end_time - Time.now
  end

  # updates the auction with a VALID bid - extends auction if needed, performs auto-bidding
  def place_bid(bid)
    user_bid = self.bids.find_by(bidder: bid.bidder)
    if user_bid.nil?
      logger.debug "user bid not found, inserting new"
      self.current_price = self.current_price + 2*self.min_increment >bid.max_amount ? bid.max_amount : self.current_price + self.min_increment
      bid.amount = self.current_price
      bid.save
    elsif user_bid.max_amount<bid.max_amount
      logger.debug "user bid found, updating"
      user_bid.update_attribute(:max_amount, bid.max_amount)
    else
      logger.debug "aborting"
      return
    end

    sorted_bids = self.bids.order(updated_at: :asc)

    modified = true
    winning_bid = Bid.new(bidder: nil, amount: 0, max_amount: 0)
    sorted_bids.each do |b|
      if b.amount>winning_bid.amount
        winning_bid = b
      end
    end

    while modified
      sorted_bids = self.bids.order(updated_at: :asc)
      modified = false
      sorted_bids.each do |b|
        if b.amount == winning_bid.amount and b!=winning_bid
          modified = true
        end
        if b != winning_bid and winning_bid.bidder != b.bidder and b.max_amount>=winning_bid.amount + self.min_increment
          modified = true

          new_price = self.current_price + ( 2*self.min_increment ) > b.max_amount ? b.max_amount : self.current_price + self.min_increment
          new_bid = bids.create(bidder: b.bidder, amount: new_price, max_amount: b.max_amount)
          winning_bid = new_bid
          self.current_price = winning_bid.amount
        end

      end
    end

    self.end_time += 15.minutes if (self.end_time - Time.now) < 5.minutes
    self.save
  end

  def assign_image(image)
    image_url = ImageUploader.new.upload image
    update_attribute(:imagePath, image_url || '')
  end

  # Returns the currently winning bid, or nil if no bid is placed
  def winning_bid
    bids.order(amount: :desc).first
  end

  # Returns the next possible bid amount
  def next_amount
    current_price + min_increment
  end

  # Ends this auction and informs winner
  def end
    # set status to :ended
    ended!

    self.winner = winning_bid.bidder
    self.save
  end

end