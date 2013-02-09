class ItemPrice < ActiveRecord::Base
  attr_accessible :name, :price, :item_id

  belongs_to :item
  has_many :shop_bundle_parts
end
