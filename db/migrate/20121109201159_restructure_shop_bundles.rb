class RestructureShopBundles < ActiveRecord::Migration
  def change
    rename_column :shop_bundles, :bundle, :name
  end
end
