class AddPositiveToOrderParts < ActiveRecord::Migration
  def change
    add_column :order_parts, :positive, :boolean
  end
end
