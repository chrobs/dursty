class RemoveCulumnTvkUsers < ActiveRecord::Migration
  def change
    remove_column :users, :tvk
    remove_column :users, :oph
  end
end
