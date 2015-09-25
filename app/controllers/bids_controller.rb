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

    if bid_is_high_enough? and bid_is_within_time?
      @bid.save
      @auction.update_price(@bid.amount)
      @auction.update_time
      flash[:success] = 'Bid successfully created'
    elsif !bid_is_within_time?
      @bid.destroy
      flash[:error] = 'Auction time is over'
    else
      @bid.destroy
      flash[:error] = 'Bid is too low'
    end
    redirect_to @auction
  end

  private
    def set_bid
      @bid = Bid.find(params[:id])
    end

    def set_auction
      @auction = Auction.find(params[:auction_id])
    end

    def bid_is_within_time?
      @auction.end_time.to_i > Time.now.to_i + 7200
    end

    def bid_is_high_enough?
      if @auction.bids.empty?
        @bid.amount >= @auction.price
      else
        @bid.amount > @auction.price
      end
    end

  def bid_params
    params.require(:bid).permit(:amount)
  end

end
