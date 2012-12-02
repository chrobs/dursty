class AddUserIdToKontos < ActiveRecord::Migration
  def change
    add_column :kontos, :user_id, :integer
  end
end
