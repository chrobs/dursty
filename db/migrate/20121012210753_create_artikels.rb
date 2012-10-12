class CreateArtikels < ActiveRecord::Migration
  def change
    create_table :artikels do |t|
      t.string :name
      t.integer :kaufpreis
      t.integer :verkaufspreis
      t.boolean :shop

      t.references :kategorie
      t.timestamps
    end
  end
end
