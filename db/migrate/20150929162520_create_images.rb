class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :url
      t.timestamps null: false
    end

    add_reference :images, :auction, index: true
  end
end
