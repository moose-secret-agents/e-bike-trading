class AuctionsController < ApplicationController
  before_action :set_auction, only: [:show, :edit, :update, :destroy]

  # GET /auctions
  def index
    @auctions = Auction.all
  end

  # GET /auctions/1
  def show
  end

  # GET /auctions/new
  def new
    @auction = Auction.new
  end

  # GET /auctions/1/edit
  def edit
  end

  # POST /auctions
  def create
    @auction = Auction.new(auction_params)

    if @auction.save
      redirect_to @auction, notice: 'Auction was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /auctions/1
  def update
    if @auction.update(auction_params)
      redirect_to @auction, notice: 'Auction was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /auctions/1
  def destroy
    @auction.destroy
    redirect_to auctions_url, notice: 'Auction was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_auction
      @auction = Auction.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def auction_params
      params.require(:auction).permit(:brand, :model, :price)
    end
end
