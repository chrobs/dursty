class AddRoomNumberToUsers < ActiveRecord::Migration
  def change
    add_column :users, :room, :integer
  end
end
