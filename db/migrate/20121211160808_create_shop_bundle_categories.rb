class CreateShopBundleCategories < ActiveRecord::Migration
  def change
    create_table :shop_bundle_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end
