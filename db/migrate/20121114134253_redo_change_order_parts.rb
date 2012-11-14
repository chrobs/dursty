class RedoChangeOrderParts < ActiveRecord::Migration
  def change
    add_column :order_parts, :positive, :boolean
    rename_column :order_parts, :bundle_id, :item_id
  end
end
