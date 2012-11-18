class AddBundlenameForOrderParts < ActiveRecord::Migration
  def change
    add_column :order_parts, :name, :string
  end
end
