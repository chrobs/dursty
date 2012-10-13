class ShrinkToOnePriceForItems < ActiveRecord::Migration
  def change
    remove_column :items, :kaufpreis
    rename_column :items, :verkaufspreis, :preis
  end
end
