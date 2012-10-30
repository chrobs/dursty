class OrderPart < ActiveRecord::Base
  attr_accessible :amount, :id, :item_id, :order_id, :positive
  belongs_to :order
end
