class RemovePriceFromItems < ActiveRecord::Migration
  def change
    remove_column :items, :preis
  end
end
