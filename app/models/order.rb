class Order < ActiveRecord::Base
  attr_accessible :closed, :id, :user_id
  belongs_to :user
  has_many :order_parts
  has_many :items, :through => :order_parts
  has_many :shop_bundles, :through => :order_parts

  def updateParts shop_bundle_id, amount
    @bundle = ShopBundle.find shop_bundle_id
    @bundle.shop_bundle_parts.each do |p|
      if self.hasBundleItemWithType p.shop_bundle_id, p.item_id, @bundle.positive
        # item available in this order: increase amount
        part = self.order_parts.where(:item_id => p.item_id,
                                      :bundle_id => p.shop_bundle_id,
                                      :positive => @bundle.positive
                                     ).first
        part.amount += amount.to_i*p.amount.to_i
        part.save
      else
        # item not yet in this order: create new order_part
        part = OrderPart.new :order_id => self.id,
                             :item_id => p.item_id,
                             :shop_bundle_id => p.shop_bundle_id,
                             :price => p.item.preis,
                             :amount => amount.to_i*p.amount.to_i,
                             :positive => @bundle.positive
        part.save
      end
    end
  end

  def hasBundleItemWithType bundle_id, item_id, positive
    return false unless self.item_ids.include? item_id
    return self.order_parts.where(:item_id => item_id,
                           :shop_bundle_id => bundle_id,
                           :positive => positive)
                           .size > 0
  end


  def gesamtpreis
    preis = 0
    self.order_parts.each do |p|
      if p.positive
        preis += p.amount * p.item.preis
      else
        preis -= p.amount * p.item.preis
      end
    end

    return preis
  end
end
