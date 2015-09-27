class RenamePriceColumnOnAuction < ActiveRecord::Migration
  def change
    rename_column :auctions, :price, :current_price
    add_column :auctions, :starting_price, :decimal
  end
end
