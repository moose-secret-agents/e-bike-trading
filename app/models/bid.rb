class Bid < ActiveRecord::Base
  belongs_to :auction
  belongs_to :bidder, class_name: 'User'

  def is_within_time?
    auction.end_time > DateTime.now
  end

  def is_high_enough?
    if auction.bids.empty?
      self.max_amount >= auction.current_price
    else
      self.max_amount >= auction.current_price + auction.min_increment
    end
  end

  class InvalidBidError < StandardError
  end
end

