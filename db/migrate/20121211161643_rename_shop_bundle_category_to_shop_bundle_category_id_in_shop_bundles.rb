class RenameShopBundleCategoryToShopBundleCategoryIdInShopBundles < ActiveRecord::Migration
  def change
    rename_column :shop_bundles, :shop_bundle_category, :shop_bundle_category_id
  end
end
