class FixFinanceTypeForItems < ActiveRecord::Migration
  def change
    change_column :items, :kaufpreis, :decimal
    change_column :items, :verkaufspreis, :decimal
  end
end
