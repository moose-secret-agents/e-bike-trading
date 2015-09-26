class Bid < ActiveRecord::Base
  belongs_to :auction
  belongs_to :bidder, class_name: 'User'

  def is_within_time?
    auction.end_time > DateTime.now
  end

  def is_high_enough?
    if auction.bids.empty?
      self.amount >= auction.price
    else
      self.amount > auction.price
    end
  end

  class InvalidBidError < StandardError
  end
end
