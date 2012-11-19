class Userkonto < ActiveRecord::Base
  attr_accessible :name, :price, :user_id

  belongs_to :user

end
