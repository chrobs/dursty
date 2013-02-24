class FixNullAndDefaultsForKontos < ActiveRecord::Migration
  def change
    change_column :kontos, :initial, :decimal, :scale => 2, :precision => 8, :default => 0, :null => false
    change_column :kontos, :name, :string, :null => false
  end
end
