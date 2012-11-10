class ShopBundle < ActiveRecord::Base
  attr_accessible :id, :name, :positive
  has_many :shop_bundle_parts
  has_many :items, :through => :shop_bundle_parts

  def getTotalCost
    total = 0
    self.shop_bundle_parts.each do |p|
      total += p.amount * p.item.preis
    end
    return total
  end

end
