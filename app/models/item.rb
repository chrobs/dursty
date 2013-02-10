class Item < ActiveRecord::Base
  attr_accessible :kategorie, :name, :item_prices_attributes
  validates_presence_of :name

  has_many :shop_bundle_parts
  has_many :order_parts
  has_many :item_prices
  accepts_nested_attributes_for :item_prices, :allow_destroy => true, :reject_if => proc { |ip| ip['price'].blank? | ip['name'].blank? }

  def self.itemsForAutocomplete
    res = self.all.map {|k| '{label: "'+k.name+'", value: "'+k.id.to_s+'"}'}.join(",")
    res = "["+res+"]"
    return res
  end

end
