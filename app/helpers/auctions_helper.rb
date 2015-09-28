module AuctionsHelper
  def end_time(auction)
    l auction.end_time, format: :countdown_format
  end
end
