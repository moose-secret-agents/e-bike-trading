class Auction < ActiveRecord::Base
  validates_presence_of :brand, :model, :price
end
