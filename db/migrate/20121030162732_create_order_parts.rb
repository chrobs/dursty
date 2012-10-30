class CreateOrderParts < ActiveRecord::Migration
  def change
    create_table :order_parts do |t|
      t.integer :id
      t.integer :order_id
      t.integer :item_id
      t.integer :amount
      t.boolean :positive

      t.timestamps
    end
  end
end
