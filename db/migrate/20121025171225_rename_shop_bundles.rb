class RenameShopBundles < ActiveRecord::Migration
  def change
    rename_table :shopbundles, :shop_bundles
  end
end
