class Itemgroup < ActiveRecord::Base
  attr_accessible :id, :menge
  has_many :items

end
