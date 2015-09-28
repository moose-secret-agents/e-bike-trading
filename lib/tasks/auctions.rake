namespace :auctions do

  desc 'End overdue auctions'
  task end_due: :environment do
    Auction.overdue.each do |auction|
      auction.end
    end
  end

end
