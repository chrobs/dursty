class Order < ActiveRecord::Base
  attr_accessible :closed, :id, :user_id
  belongs_to :user
  has_many :order_parts
  has_many :order_part_items, :through => :order_parts
  has_many :items, :through => :order_part_items
  has_many :shop_bundles, :through => :order_parts
  has_many :user_account_bills, :through => :user

  scope :closed, where(:closed => true)

  def updateParts shop_bundle_id, amount
    # check if bundle already in order
    part = OrderPart.where :order_id => self.id,
                           :shop_bundle_id => shop_bundle_id

    if part.size == 1
      # bundle exists in order, update amount
      part = part.first
      part.amount += amount.to_i
      return part.save
    elsif part.size == 0
      # bundle not yet in order, create order_part and order_part_items
      bundle = ShopBundle.find shop_bundle_id
      part = OrderPart.new :order_id => self.id,
                           :shop_bundle_id => shop_bundle_id,
                           :amount => amount,
                           :positive => bundle.positive,
                           :name => bundle.name
      # save order part
      return false unless part.save

      # create order_part_items for order_part from shop_bundle_id
      return part.createPartItems bundle
    else
      # error: more than one order_part for same shop_bundle
      return false
    end
  end

  def gesamtpreis
    preis = 0
    self.order_parts.each do |p|
      preis += p.amount * p.sumOfPartItems
    end

    return preis
  end
end
