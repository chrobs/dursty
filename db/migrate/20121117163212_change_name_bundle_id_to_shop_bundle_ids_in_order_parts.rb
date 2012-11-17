class ChangeNameBundleIdToShopBundleIdsInOrderParts < ActiveRecord::Migration
  def change
    rename_column :order_parts, :bundle_id, :shop_bundle_id
  end
end
