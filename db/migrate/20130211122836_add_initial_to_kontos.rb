class AddInitialToKontos < ActiveRecord::Migration
  def change
    add_column :kontos, :initial, :decimal, :scale => 2, :precision => 8, :default => 0
  end
end
