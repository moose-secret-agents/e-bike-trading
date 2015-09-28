module TaskHelpers

  def self.end_overdue_auctions
    count = Auction.overdue.count
    Rails.logger.debug "Ending #{count} overdue auctions now"

    Auction.overdue.each do |auction|
      auction.end
    end
  end

end