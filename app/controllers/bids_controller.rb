class BidsController < ApplicationController
  before_action :set_auction, only: [:index, :create, :new]
  before_action :require_login, only: [:new, :create]

  rescue_from Bid::InvalidBidError do |error|
    redirect_to @auction, alert: error.message
  end

  def index
    @bids = @auction.bids
  end

  def new
    @bid = current_user.bids.build(auction: @auction)
  end

  # POST /bids
  def create
    @bid = current_user.place_bid_on(@auction, bid_params[:amount])

    redirect_to @auction, notice: 'Successfully placed bid'
  end


  private

    def set_bid
      @bid = Bid.find(params[:id])
    end

    def set_auction
      @auction = Auction.find(params[:auction_id])
    end



  def bid_params
    params.require(:bid).permit(:amount)
  end

end
