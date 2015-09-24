class AddPowerAndRangeToAuctions < ActiveRecord::Migration
  def change
    add_column :auctions, :power, :integer
    add_column :auctions, :range, :integer
  end
end
