class CreateItemPrices < ActiveRecord::Migration
  def change
    create_table :item_prices do |t|
      t.string :name
      t.decimal :price, :default => 0, :precision => 8, :scale => 2
      t.references :item
      t.timestamps
    end
  end
end
