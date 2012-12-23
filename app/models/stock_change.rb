class StockChange < ActiveRecord::Base
  attr_accessible :shop_bundle_id, :stock_id, :amount, :name

  belongs_to :shop_bundle
  belongs_to :stock
end
