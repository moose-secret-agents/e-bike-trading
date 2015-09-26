class Auction < ActiveRecord::Base
  validates_presence_of :brand, :model, :price
  validates :price, :numericality => { :greater_than_or_equal_to => 1 }

  has_many :bids

  belongs_to :creator, class_name: 'User' #instead of belongs_to :user, which is not very readable
  has_many :bidders, through: :bids


  def update_price max_bid
    self.price = max_bid
    self.save
  end

  def update_time
    remaining_time = ((self.end_time.to_i - Time.now.to_i)/60 -120)

    if remaining_time < 5
      self.end_time += 900 # 15min
      self.save
    end
  end

end