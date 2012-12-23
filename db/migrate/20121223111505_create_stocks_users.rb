class CreateStocksUsers < ActiveRecord::Migration
  def change
    create_table :stocks_users do |t|
      t.integer :stock_id
      t.integer :user_id
    end
  end
end
