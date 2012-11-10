class ChangeNameOfTypeInShopBundles < ActiveRecord::Migration
  def change
    rename_column :shop_bundles, :type, :positive
  end
end
