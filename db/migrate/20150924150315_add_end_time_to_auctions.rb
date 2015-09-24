class AddEndTimeToAuctions < ActiveRecord::Migration
  def change
    add_column :auctions, :end_time, :datetime
  end
end
