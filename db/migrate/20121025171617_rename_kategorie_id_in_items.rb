class RenameKategorieIdInItems < ActiveRecord::Migration
  def change
    rename_column :items, :kategorie_id, :kategorie
  end
end
