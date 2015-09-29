class AuctionsController < ApplicationController
  before_action :set_auction, only: [:show, :edit, :update, :destroy, :tweet, :delete_images]
  before_action :require_login, only: [:new, :edit, :create, :update]

  # GET /auctions
  def index
    auctions = case params[:filter]
                  when 'running' then Auction.running
                  when 'ended' then Auction.ended
                  when 'all' then Auction.all
                  else Auction.running
               end

    @auctions = auctions.order(end_time: :asc)
  end

  # GET /auctions/1
  def show
    #@image_link=Auction.find(:id)
  end

  # GET /auctions/new
  def new
    @auction = current_user.auctions.build(min_increment:5, end_time: DateTime.now + 1.week)
    5.times { @auction.images.build }
  end

  # GET /auctions/1/edit
  def edit
    authorize @auction
  end

  # POST /auctions
  def create
    @auction = current_user.auctions.create(auction_params)

    upload_images @auction

    if @auction.save
      redirect_to @auction, notice: 'Auction was successfully created.'
    else
      render :new
    end
  end

  def tweet
    Twitterer.new.tweet("Checkout this awesome auction: #{auction_url(@auction)}")
    redirect_to :back, notice: 'Tweet sent!'
  end

  def delete_images
    @auction.images.destroy_all
    redirect_to :back, notice: 'Images deleted. Edit auction to add new images...'
  end

  # PATCH/PUT /auctions/1
  def update
    authorize @auction

    if @auction.update(auction_params)
      upload_images(@auction)
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
      params.require(:auction).permit(:brand, :model, :description, :starting_price, :power, :range, :end_time, :min_increment)
    end

    def upload_images(auction)
      # upload image to imgur if image was given in form
      if params[:auction][:images]
        params[:auction][:images].each do |uploaded_file|
          auction.assign_image uploaded_file.tempfile
        end
      end
    end
end
