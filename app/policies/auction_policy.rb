class AuctionPolicy
  attr_reader :user, :auction

  def initialize(user, auction)
    @user = user
    @auction = auction
  end

  def destroy?
    is_creator? and auction.bids.count == 0
  end

  def edit?
    is_creator?
  end

  def update?
    is_creator?
  end

  def delete_images?
    is_creator?
  end

  private
  def is_creator?
    user == @auction.creator
  end
end