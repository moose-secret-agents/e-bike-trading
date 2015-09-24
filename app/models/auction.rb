class Auction < ActiveRecord::Base
  validates_presence_of :brand, :model, :price

  has_many :bids
  belongs_to :creator, class_name: 'User' #instead of belongs_to :user, which is not very readable
  has_many :bidders, through: :bids
end