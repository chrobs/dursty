class StockChange < ActiveRecord::Base
  attr_accessible :shop_bundle_id, :stock_id, :amount, :name

  belongs_to :shop_bundle
  belongs_to :stock

  def inventory
    inv = self.shop_bundle.inventory
    inv.each do |item, amount|
      inv[item] = amount * self.amount
    end
    return inv
  end
end
