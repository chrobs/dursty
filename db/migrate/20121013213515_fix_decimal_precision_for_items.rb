class FixDecimalPrecisionForItems < ActiveRecord::Migration
    change_column :items, :kaufpreis, :decimal, :default => 0, :precision => 8, :scale => 2
    change_column :items, :verkaufspreis, :decimal, :default => 0, :precision => 8, :scale => 2
end
