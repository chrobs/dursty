class CreateUserkontos < ActiveRecord::Migration
  def change
    create_table :userkontos do |t|
      t.string :name
      t.decimal :price

      t.timestamps
    end
  end
end
