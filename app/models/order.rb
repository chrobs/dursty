class Order < ActiveRecord::Base
  attr_accessible :closed, :id, :user
  belongs_to :user
  has_many :order_parts
end
