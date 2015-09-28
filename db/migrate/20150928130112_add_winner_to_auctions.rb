class AddWinnerToAuctions < ActiveRecord::Migration
  def change
    add_reference :auctions, :winner, index: true
  end
end
