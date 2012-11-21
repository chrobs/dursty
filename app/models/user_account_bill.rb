class UserAccountBill < ActiveRecord::Base
  attr_accessible :name, :price, :user_id

  belongs_to :user

end
