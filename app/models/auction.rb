class Auction < ActiveRecord::Base
  validates_presence_of :imagePath, :brand, :model, :price

  has_many :bids
end