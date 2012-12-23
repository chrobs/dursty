class ChangeLocationToStockIdInOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :location
    add_column :orders, :stock_id, :integer
  end
end
