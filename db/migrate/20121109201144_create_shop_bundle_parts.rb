class CreateShopBundleParts < ActiveRecord::Migration
  def change
    create_table :shop_bundle_parts do |t|
      t.integer :id
      t.integer :shop_bundle_id
      t.integer :item_id
      t.integer :amount

      t.timestamps
    end
  end
end
