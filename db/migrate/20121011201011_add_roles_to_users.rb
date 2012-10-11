class AddRolesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :admin, :boolean
    add_column :users, :kassenwart, :boolean
    add_column :users, :lagerwart, :boolean
  end
end
