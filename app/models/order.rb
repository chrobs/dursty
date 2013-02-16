class Order < ActiveRecord::Base
  attr_accessible :closed, :id, :user_id, :stock_id

  validates_presence_of :user_id, :stock_id

  belongs_to :user
  has_many :order_parts
  has_many :order_part_items, :through => :order_parts
  has_many :items, :through => :order_part_items
  has_many :shop_bundles, :through => :order_parts
  has_many :user_account_bills, :through => :user
  belongs_to :stock

  scope :closed, where(:closed => true)

  @@expiration = 8

  def expired
    return self.created_at < @@expiration.days.ago.beginning_of_day
  end

  def updateParts shop_bundle_id, amount
    # check if bundle already in order
    part = OrderPart.where :order_id => self.id,
                           :shop_bundle_id => shop_bundle_id

    if part.size == 1
      # bundle exists in order, update amount
      part = part.first
      part.amount += amount.to_i
      # update amount of partItems
      return false unless part.updateItems shop_bundle_id, amount
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
      #return part.createPartItems bundle
      return part.updateItems shop_bundle_id, amount
    else
      # error: more than one order_part for same shop_bundle
      return false
    end
  end

  def removePart shop_bundle_id
    # check if bundle in order
    part = OrderPart.where :order_id => self.id,
                           :shop_bundle_id => shop_bundle_id
    if part.size == 1
      # part exists in order, get first
      part = part.first

      # remove order_part_items
      return false unless part.removePartItems

      # remove order_part
      return part.destroy

    elsif part.size == 0
      # not existent in order, job done
      return true
    else
      # error: more than one order_part for same shop_bundle
      return false
    end

  end

  def gesamtpreis
    preis = 0
    self.order_parts.each do |p|
      preis += p.sumOfPartItems
    end

    return preis
  end

  def inventory
    inv = Hash.new(0)
    self.order_parts.each do |p|
      p.inventory.each do |item,amount|
        inv[item] += amount
      end
    end
    return inv
  end
end
