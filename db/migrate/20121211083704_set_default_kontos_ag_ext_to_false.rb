class SetDefaultKontosAgExtToFalse < ActiveRecord::Migration
  def change
    change_column :kontos, :ext, :boolean, :default => false
    change_column :kontos, :ag, :boolean, :default => false
  end
end
