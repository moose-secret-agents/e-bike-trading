class Auction < ActiveRecord::Base
  validates_presence_of :brand, :model, :price
  validates :price, :numericality => { :greater_than_or_equal_to => 1 }

  has_many :bids

  belongs_to :creator, class_name: 'User' #instead of belongs_to :user, which is not very readable
  has_many :bidders, through: :bids


  # updates the auction with a VALID bid - extends auction if needed
  def place_bid(bid)
    self.price = self.price + self.min_increment
    bid.amount = self.price
    bid.save

    sorted_bids = self.bids.order(created_at: :asc)

    modified = true
    #todo : fix issue where bids escalate when they shouldn't - happens when there are two bids fighting against each other
    while modified
      #sorted_bids = self.bids.order(created_at: :asc)
      modified = false
      sorted_bids.each do |b|
        puts  b.amount >= self.price
        puts "b.amount #{b.amount} and self.price #{self.price}"
        next if (b.max_amount < self.price + self.min_increment) or b.amount >= self.price
        modified = true
        bids.create(bidder: b.bidder, amount: self.price + self.min_increment, max_amount: b.max_amount) #TODO: check if double increment possible, else insert max_value instead of incremented val
        puts "current price: #{self.price}, #{b.bidder}, amount: #{self.price + self.min_increment}, max_amount : #{b.max_amount}"
        self.price += min_increment
      end
    end

    self.end_time += 15.minutes if (self.end_time - Time.now) < 5.minutes
    self.save
  end

  def assign_image(image)
    image_url = ImageUploader.new.upload image
    update_attribute(:imagePath, image_url || '')
  end

end