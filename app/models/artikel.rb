class Artikel < ActiveRecord::Base
  attr_accessible :kategorie_id, :kaufpreis, :name, :shop, :verkaufspreis
end
