class AddBundleAndPriceToOrderParts < ActiveRecord::Migration
  def change
    add_column :order_parts, :bundle_id, :integer
    add_column :order_parts, :price, :decimal, :default => 0, :precision => 8, :scale => 2

  end
end
