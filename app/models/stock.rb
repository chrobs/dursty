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

  # sold bundles between from-date and to-date
  def soldBundles from, to
    res = Hash.new

    # get orders in time frame
    self.orders.closed.where(:created_at => from..to).each do |o|
      # get sold Bundles hash {bundle => {:bundleAmount => bAmount, :items => {item => iAmount}}
      o.soldBundles.each do |bundle, bundleAmountItems|
        # check bundle
        res[bundle] = {:bundleAmount => 0, :items => Hash.new(0)} unless res[bundle]

        # merge bundle amount
        res[bundle][:bundleAmount] += bundleAmountItems[:bundleAmount]

        # merge into res[bundle][item]
        bundleAmountItems[:items].each do |item, iAmount|
          res[bundle][:items][item] += iAmount
        end
      end
    end
    return res
  end
end
