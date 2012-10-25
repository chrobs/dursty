class DropShopFlagForItems < ActiveRecord::Migration
  def change
    remove_column :items, :shop
  end
end
