class RenameColumnsInOrders < ActiveRecord::Migration
  def change
    rename_column :orders, :user, :user_id
  end
end
