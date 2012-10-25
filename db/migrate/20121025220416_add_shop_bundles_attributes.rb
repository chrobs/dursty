class AddShopBundlesAttributes < ActiveRecord::Migration
  def change
    add_column :shop_bundles, :name, :string
  end
end
