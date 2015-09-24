class BidsController < ApplicationController
  before_action :set_auction, only: [:index, :create, :new]

  # GET /bids
  def index
    @bids = @auction.bids
  end

  # GET /bids/new
  def new
    @auction = Auction.find(params[:auction_id])
    @bid = @auction.bids.build
  end

  # POST /bids
  def create
    @bid = @auction.bids.create(bid_params)

    if @bid.save
      redirect_to @auction, notice: 'Bid was successfully created.'
    else
      render :new
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bid
      @bid = Bid.find(params[:id])
    end

    def set_auction
      @auction = Auction.find(params[:auction_id])
    end

    # Only allow a trusted parameter "white list" through.
    def bid_params
      params.require(:bid).permit(:amount)
    end
end
