class RenameShopBundleCategoryToShopBundleCategoryIdInShopBundles < ActiveRecord::Migration
  def change
    remove_column :shop_bundles, :shop_bundle_category
  end
end
