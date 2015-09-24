class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.decimal :amount

      t.timestamps null: false
    end
  end
end
