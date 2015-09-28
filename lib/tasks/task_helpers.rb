module TaskHelpers

  def self.end_overdue_auctions
    count = Auction.overdue.select { |a| !a.ended? }.count
    Rails.logger.debug "Ending #{count} overdue auctions now"

    Auction.overdue.each do |auction|
      auction.end unless auction.ended?
    end
  end

end