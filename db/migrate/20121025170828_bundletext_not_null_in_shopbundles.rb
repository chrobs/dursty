class BundletextNotNullInShopbundles < ActiveRecord::Migration
  def change
    change_column :shopbundles, :bundle, :text, :null => false
  end
end
