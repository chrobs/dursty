class OrderPart < ActiveRecord::Base
  attr_accessible :amount, :id, :item_id, :shop_bundle_id, :price, :order_id, :positive
  belongs_to :order
  belongs_to :item
  belongs_to :shop_bundle
end
