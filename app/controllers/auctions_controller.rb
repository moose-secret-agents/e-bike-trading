class AuctionsController < ApplicationController
  before_action :set_auction, only: [:show, :edit, :update, :destroy]

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
    @auction = Auction.new
  end

  # GET /auctions/1/edit
  def edit
  end

  # POST /auctions
  def create
    imgurClient = Imgur.new 'be637321cf3de65'

    imgLink=params[:auction][:imagePath]

    #'/home/dominicsina/Desktop/RubyProjects/e-bike-trading/app/assets/images/test.jpg'
    img = Imgur::LocalImage.new(imgLink, title: 'Test post please ignore')
    uploaded = imgurClient.upload(img)
    #puts "uploaded: #{uploaded.link}"
    #"<img src='#{uploaded.link}' /><p>Uploaded to #{uploaded.link}</p>"
    @image_link=uploaded.link


    @auction = Auction.new(auction_params)
    @auction.imagePath=@image_link
    #@auction.imagePath=@auction
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
      params.require(:auction).permit(:imagePath, :brand, :model, :price, :power, :range)
    end
end
