class ShopBundle < ActiveRecord::Base
  attr_accessible :id, :bundle

  def self.all
    super
  end
end
