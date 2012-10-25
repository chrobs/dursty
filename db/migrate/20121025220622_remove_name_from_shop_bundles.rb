class RemoveNameFromShopBundles < ActiveRecord::Migration
  def change
    remove_column :shop_bundles, :name
  end
end
