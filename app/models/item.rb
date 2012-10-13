class Item < ActiveRecord::Base
  attr_accessible :kategorie_id, :kaufpreis, :name, :shop, :verkaufspreis
  validates_presence_of :name, :kategorie_id, :kaufpreis, :verkaufspreis

  belongs_to :itemgroup
end
