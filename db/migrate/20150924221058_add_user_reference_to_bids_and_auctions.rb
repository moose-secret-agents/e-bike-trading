class AddUserReferenceToBidsAndAuctions < ActiveRecord::Migration
  def change
    add_reference :auctions, :creator, index: true
    add_reference :bids, :bidder, index: true
  end
end
