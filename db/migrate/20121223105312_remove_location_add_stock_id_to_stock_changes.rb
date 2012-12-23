class RemoveLocationAddStockIdToStockChanges < ActiveRecord::Migration
  def change
    remove_column :stock_changes, :location
    add_column :stock_changes, :stock_id, :integer
  end
end
