class OrderPart < ActiveRecord::Base
  attr_accessible :amount, :id, :shop_bundle_id, :order_id, :positive, :name
  belongs_to :order
  belongs_to :shop_bundle
  has_many :order_part_items
  has_many :items, :through => :order_part_items

  def createPartItems shop_bundle
    shop_bundle.shop_bundle_parts.each do |p|
     partItem = OrderPartItem.new :order_part_id => self.id,
                                  :item_id => p.item_id,
                                  :amount => p.amount,
                                  :price => p.item_price.price,
                                  :name => p.item.name
      return false unless partItem.save
    end
    return true
  end

  def removePartItems
    return self.order_part_items.destroy_all
  end

  def sumOfPartItems
    sum = 0
    self.order_part_items.each do |i|
      sum += i.amount * i.price
    end

    sum = sum*(-1) unless self.positive

    return sum
  end

  def inventory
    inv = {}
    self.shop_bundle.inventory.each do |item, amount|
      inv[item] = amount * self.amount
      # count negative for outgoing and positive for incoming items
      inv[item] *= (-1) if self.positive
    end
    return inv
  end
end
