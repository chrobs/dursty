class ChangeItemgroupsToShopBundles < ActiveRecord::Migration
  def change
    rename_table :itemgroups, :shopbundles
    remove_column :shopbundles, :main_item
    remove_column :shopbundles, :menge
    remove_column :shopbundles, :item_id
    add_column :shopbundles, :bundle, :text
  end
end
