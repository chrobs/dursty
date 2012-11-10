class Item < ActiveRecord::Base
  attr_accessible :kategorie, :preis, :name
  validates_presence_of :name, :preis

  has_many :shop_bundle_parts

  def self.itemsForAutocomplete
    res = self.all.map {|k| '{label: "'+k.name+'", value: "'+k.id.to_s+'"}'}.join(",")
    res = "["+res+"]"
    return res
  end

end
