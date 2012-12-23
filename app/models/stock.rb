class Stock < ActiveRecord::Base
  attr_accessible :name

  has_many :stock_changes
  has_many :orders
  has_and_belongs_to_many :users

  def inventory
    inv = {}
    self.orders.each do |o|
      o.inventory.each do |bundle, amount|
        if inv[bundle]
          inv[bundle] += amount
        else
          inv[bundle] = amount
        end
      end
    end
    return inv
  end
end
