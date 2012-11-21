class RenameUserkontoToUserkontoBuchung < ActiveRecord::Migration
  def change
    rename_table :userkontos, :user_account_bills
  end
end
