class Stock < ActiveRecord::Base
  attr_accessible :name

  has_many :stock_changes
  has_many :orders
  has_and_belongs_to_many :users

  def inventory
    inv = {}

    Item.all.each do |i|
      inv[i] = 0
    end

    self.stock_changes.each do |sc|
      sc.inventory.each do |item, amount|
        inv[item] += amount
      end
    end

    self.orders.each do |o|
      o.inventory.each do |item,amount|
        inv[item] += amount
      end
    end
    return inv
  end
end
