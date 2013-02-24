class KontosInitialNullFalse < ActiveRecord::Migration
  def change
    change_column :kontos, :initial, :decimal, :null => false
  end
end
