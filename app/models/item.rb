class Item < ActiveRecord::Base
  attr_accessible :kategorie, :preis, :name
  validates_presence_of :name, :preis
end
