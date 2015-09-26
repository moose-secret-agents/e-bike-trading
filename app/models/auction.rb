class Auction < ActiveRecord::Base
  validates_presence_of :brand, :model, :price
  validates :price, :numericality => { :greater_than_or_equal_to => 1 }

  has_many :bids

  belongs_to :creator, class_name: 'User' #instead of belongs_to :user, which is not very readable
  has_many :bidders, through: :bids


  # updates the auction with a VALID bid - extends auction if needed
  def place_bid(bid)
    self.price = bid.amount
    self.end_time += 15.minutes if (self.end_time - Time.now) < 5.minutes
    self.save
  end

end