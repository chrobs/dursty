class NewTableShopBundleCategoriesShopBundles < ActiveRecord::Migration
  def change
    create_table :shop_bundle_categories_shop_bundles do |t|
      t.integer :shop_bundle_id
      t.integer :shop_bundle_category_id

      t.timestamps
    end
  end
end
