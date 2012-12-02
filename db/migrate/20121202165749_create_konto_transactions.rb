class CreateKontoTransactions < ActiveRecord::Migration
  def change
    create_table :konto_transactions do |t|
      t.integer :from
      t.integer :to
      t.string :name
      t.decimal :price, :default => 0, :precision => 8, :scale => 2
    end
  end
end
