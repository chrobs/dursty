class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :id
      t.integer :user
      t.boolean :closed

      t.timestamps
    end
  end
end
