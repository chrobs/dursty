class FixDefaultValuesForItems < ActiveRecord::Migration
    change_column :items, :kaufpreis, :decimal, :default => 0
    change_column :items, :verkaufspreis, :decimal, :default => 0
end
