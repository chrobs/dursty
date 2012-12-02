class CreateKontos < ActiveRecord::Migration
  def change
    create_table :kontos do |t|
      t.string :name
    end
  end
end
