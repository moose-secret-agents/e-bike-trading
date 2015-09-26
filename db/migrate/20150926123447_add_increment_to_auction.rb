class AddIncrementToAuction < ActiveRecord::Migration
  def change
    add_column :auctions, :min_increment, :integer
  end
end
