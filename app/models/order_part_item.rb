class OrderPartItem < ActiveRecord::Base
  attr_accessible :amount, :item_id, :name, :order_part_id, :price

  belongs_to :order_part
  belongs_to :item
  belongs_to :order

  def inventory
    inv = Hash.new(0)
    inv[self.item] = self.amount
    return inv
  end

end
