class AuctionsController < ApplicationController
  before_action :set_auction, only: [:show, :edit, :update, :destroy]
  before_action :require_login, only: [:new, :edit, :create, :update]

  # GET /auctions
  def index
    @auctions = Auction.all
  end

  # GET /auctions/1
  def show
    #@image_link=Auction.find(:id)
  end

  # GET /auctions/new
  def new
    @auction = current_user.auctions.build(min_increment:5,end_time: DateTime.now + 1.week)
  end

  # GET /auctions/1/edit
  def edit
    authorize @auction
  end

  # POST /auctions
  def create
    @auction = current_user.auctions.create(auction_params)

    # upload image to imgur if image was given in form
    if params[:auction][:imagePath]
      uploaded_image = params[:auction][:imagePath].tempfile
      @auction.assign_image uploaded_image
    end

    if @auction.save
      redirect_to @auction, notice: 'Auction was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /auctions/1
  def update
    authorize @auction

    if @auction.update(auction_params)
      redirect_to @auction, notice: 'Auction was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /auctions/1
  def destroy
    authorize @auction

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
      params.require(:auction).permit(:imagePath, :brand, :model, :price, :power, :range, :end_time, :min_increment)
    end
end
