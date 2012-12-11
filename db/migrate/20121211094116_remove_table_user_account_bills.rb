class RemoveTableUserAccountBills < ActiveRecord::Migration
  def change
    drop_table :user_account_bills
  end
end
