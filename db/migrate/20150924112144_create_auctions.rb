class CreateAuctions < ActiveRecord::Migration
  def change
    create_table :auctions do |t|
      t.string :brand
      t.string :model
      t.decimal :price

      t.timestamps null: false
    end
  end
end
