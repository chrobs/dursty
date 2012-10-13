class NameOfShopproduct < ActiveRecord::Migration
  def change
    rename_table :shopproducts, :itemgroups
    rename_column :itemgroups, :item_id, :subitem
  end
end
