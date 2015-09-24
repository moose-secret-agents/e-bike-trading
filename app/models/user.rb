class User < ActiveRecord::Base
  authenticates_with_sorcery!

  has_many :auctions, foreign_key: 'creator_id'
  has_many :bids, foreign_key: 'bidder_id'

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes["password"] }
  validates :password, confirmation: true, if: -> { new_record? || changes["password"] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes["password"] }

  validates :email, uniqueness: true

  # Creates a new bid on the supplied auction with the specified amount
  def place_bid_on(auction, amount)
    bids.create(auction: auction, amount: amount)
  end
end