class AddKontoTypeFlagToKontos < ActiveRecord::Migration
  def change
    add_column :kontos, :ext, :boolean
    add_column :kontos, :ag, :boolean
  end
end
