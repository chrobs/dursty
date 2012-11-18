class CreateOrderPartItems < ActiveRecord::Migration
  def change
    create_table :order_part_items do |t|
      t.integer :order_part_id
      t.integer :item_id
      t.integer :amount
      t.decimal :price, :default => 0, :precision => 8, :scale => 2
      t.string :name

      t.timestamps
    end
  end
end
