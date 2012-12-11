class RemoveTimestampsFromShopBundleCategoriesShopBundles < ActiveRecord::Migration
  def down
    remove_column :shop_bundle_categories_shop_bundles, :created_at
    remove_column :shop_bundle_categories_shop_bundles, :updated_at
  end
end
