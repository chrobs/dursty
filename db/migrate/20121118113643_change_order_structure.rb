class ChangeOrderStructure < ActiveRecord::Migration
  def change
    remove_column :order_parts, :shop_bundle_id
    remove_column :order_parts, :price
    remove_column :order_parts, :positive
    rename_column :order_parts, :item_id, :shop_bundle_id
  end
end
