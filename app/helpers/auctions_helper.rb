module AuctionsHelper
  def end_time(auction)
    l auction.end_time, format: :countdown_format
  end

  def description_html(auction)
    auction.description.gsub(/\n/, '<br/>').html_safe
  end
end
