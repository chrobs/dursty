class CreateStockChanges < ActiveRecord::Migration
  def change
    create_table :stock_changes do |t|
      t.integer   :shop_bundle_id
      t.string    :location
      t.integer   :amount
      t.string    :name

      t.timestamps
    end
  end
end
