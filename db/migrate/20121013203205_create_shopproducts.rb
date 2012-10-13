class CreateShopproducts < ActiveRecord::Migration
  def change
    create_table :shopproducts do |t|
      t.integer :id
      t.integer :menge
      t.references :item

      t.timestamps
    end
  end
end
