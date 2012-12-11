class RemoveKategorieFromTableItems < ActiveRecord::Migration
  def change
    remove_column :items, :kategorie
  end
end
