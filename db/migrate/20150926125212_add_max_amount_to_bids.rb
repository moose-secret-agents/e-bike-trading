class AddMaxAmountToBids < ActiveRecord::Migration
  def change
    add_column :bids, :max_amount, :decimal
  end
end
