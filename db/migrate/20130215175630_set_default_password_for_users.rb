class SetDefaultPasswordForUsers < ActiveRecord::Migration
  def change
    change_column :users, :encrypted_password, :string, :default => "$2a$10$cbAQQyQlgX6Iljl4wfT3ueciZvsjeEwlZp6fgizvzYXtpwqnLwyPW"
  end
end
