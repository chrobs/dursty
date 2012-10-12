class NameOfArtikels < ActiveRecord::Migration
  def change
    rename_table :artikels, :items
  end
end
