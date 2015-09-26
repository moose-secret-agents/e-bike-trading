class AddImagePathToAuctions < ActiveRecord::Migration
  def change
    add_column :auctions, :imagePath, :string
  end
end
