class AddItemPriceToShopBundleParts < ActiveRecord::Migration
  def change
    add_column :shop_bundle_parts, :item_price_id, :integer
  end
end
