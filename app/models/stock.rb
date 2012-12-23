class Stock < ActiveRecord::Base
  attr_accessible :name

  has_many :stock_changes
  has_and_belongs_to_many :users

end
