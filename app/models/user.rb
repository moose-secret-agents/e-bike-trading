class User < ActiveRecord::Base
  authenticates_with_sorcery!

  has_many :auctions, foreign_key: 'creator_id'
  has_many :bids, foreign_key: 'bidder_id'

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes["password"] }
  validates :password, confirmation: true, if: -> { new_record? || changes["password"] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes["password"] }

  validates :email, uniqueness: true

  # Creates a new bid on the supplied auction with the specified amount
  # returns error message
  def place_bid_on(auction, max_amount)
    bid = bids.build(auction: auction, max_amount: max_amount)
    if bid.is_high_enough? and bid.is_within_time?
      #bid.save
      auction.place_bid bid
    elsif !bid.is_within_time?
      raise Bid::InvalidBidError.new 'Auction time is over'
    else
      raise Bid::InvalidBidError.new 'Bid is too low'
    end
    bid
  end

end
