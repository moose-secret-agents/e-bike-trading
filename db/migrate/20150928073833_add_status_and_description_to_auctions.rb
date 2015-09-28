class AddStatusAndDescriptionToAuctions < ActiveRecord::Migration
  def change
    add_column :auctions, :status, :integer, default: 0
    add_column :auctions, :description, :text, default: ''
  end
end
