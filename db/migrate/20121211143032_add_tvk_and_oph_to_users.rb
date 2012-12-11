class AddTvkAndOphToUsers < ActiveRecord::Migration
  def change
    add_column :users, :tvk, :boolean, :default => false
    add_column :users, :oph, :boolean, :default => false
  end
end
