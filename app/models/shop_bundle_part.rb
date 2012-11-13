class ShopBundlePart < ActiveRecord::Base
  attr_accessible :amount, :id, :item_id, :shop_bundle_id
  belongs_to :shop_bundle
  belongs_to :item

  def self.newFromBundleParams params
    (1..(params[:shop_bundle][:max_items].to_i)).each do |i|
      id = params[:shop_bundle][:shop_bundle_parts]["item_id_" + i.to_s]
      amount = params[:shop_bundle][:shop_bundle_parts]["item_amount_" + i.to_s]

      next if id.nil? || id.empty? || amount.empty? || amount.nil?

      self.new do |s|
        s.shop_bundle_id = params[:id]
        s.item_id = id
        s.amount = amount
        return false unless s.save
      end
    end
    return true
  end
end
