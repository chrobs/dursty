class ShopBundle < ActiveRecord::Base
  attr_accessible :id, :name, :positive, :shop_bundle_parts_attributes

  has_many :shop_bundle_parts
  accepts_nested_attributes_for :shop_bundle_parts, :allow_destroy => true

  has_many :items, :through => :shop_bundle_parts
  has_many :order_parts
  has_and_belongs_to_many :shop_bundle_categories
  has_many :stock_changes

  def getTotalCost
    total = 0
    self.shop_bundle_parts.each do |p|
      total += p.amount * p.item_price.price
    end

    total = total * (-1) unless self.positive

    return total
  end

  def inventory
    inv = {}
    self.shop_bundle_parts.each do |p|
      inv[p.item] = p.amount
    end
    return inv
  end
end
