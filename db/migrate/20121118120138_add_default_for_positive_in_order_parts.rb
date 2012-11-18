class AddDefaultForPositiveInOrderParts < ActiveRecord::Migration
  def change
    change_column :order_parts, :positive, :boolean, :default => true
  end
end
