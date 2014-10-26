class ShopBundle < ActiveRecord::Base
  attr_accessible :id, :name, :positive, :shop_bundle_parts_attributes, :shop_bundle_category_ids, :image, :remove_image

  has_many :shop_bundle_parts
  accepts_nested_attributes_for :shop_bundle_parts, :allow_destroy => true, :reject_if => proc {|a| a['item_id'].blank? | a['amount'].blank? | a['item_price_id'].blank?}

  has_and_belongs_to_many :shop_bundle_categories
  has_many :items, :through => :shop_bundle_parts
  has_many :order_parts
  has_many :stock_changes

  # paperclip image
  has_attached_file :image,
    :removable => true,
    :styles => {:medium => "300x300>", :thumb => "100x100>", :xs => "50x50>"},
    :default_url => "/assets/missing.png"
  validates_attachment :image,
    :content_type => { :content_type => ["image/jpg","image/jpeg", "image/png"] },
    :size => { :in => 0..5.megabytes }

  def getTotalCost
    total = 0
    self.shop_bundle_parts.each do |p|
      return false unless p.item_price
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
