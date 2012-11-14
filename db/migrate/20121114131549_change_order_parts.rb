class ChangeOrderParts < ActiveRecord::Migration
  def change
    remove_column :order_parts, :positive
    rename_column :order_parts, :item_id, :bundle_id
  end
end
