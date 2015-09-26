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
    imgurClient = Imgur.new 'be637321cf3de65'

    begin
      img = Imgur::LocalImage.new(params[:auction][:imagePath], title: 'Test post please ignore')
      uploaded = imgurClient.upload(img)
      link=uploaded.link
    rescue
      link=''
    end

    @auction = current_user.auctions.create(auction_params)
    @auction.imagePath=link
    #@auction.imagePath=@auction
    if @auction.save
      redirect_to @auction, notice: 'Auction was successfully created.'
    else
      render :new
    end
  rescue

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
      params.require(:auction).permit(:imagePath, :brand, :model, :price, :power, :range, :end_time, :increment)
    end
end
