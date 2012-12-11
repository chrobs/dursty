class AddCategoryToTableShopBundles < ActiveRecord::Migration
  def change
    add_column :shop_bundles, :shop_bundle_category, :integer
  end
end
