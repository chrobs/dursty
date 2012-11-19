class AddUserIdToUserkonto < ActiveRecord::Migration
  def change
    add_column :userkontos, :user_id, :integer
    change_column :userkontos, :price, :decimal, :default => 0, :precision => 8, :scale => 2
  end
end
