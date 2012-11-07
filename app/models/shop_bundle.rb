class ShopBundle < ActiveRecord::Base
  attr_accessible :id, :bundle

  def self.all
    super
  end

  def self.new *args
    if args.size == 0
      super
    else
      bundle = self.paramsToJson args[0]
      super :bundle => bundle
    end
  end

  #
  # gets params from shopBundle new-method and returns JSON string
  #
  def self.paramsToJson params
    bundle = {}
    bundle[:name] = params[:name]
    bundle[:type] = params[:type]

    # build hash of Item_id => Amount for each item in the bundle
    bundle[:items] = {}
    (1..params[:max_items].to_i).each do |i|
      id = params["item_id_" + i.to_s]
      amount = params["item_amount_" + i.to_s]

      next if id.nil? || id.empty? || amount.empty? || amount.nil?

      bundle[:items][id] = amount
    end

    return bundle.to_json
  end

  #
  # gets params from shopBundle new-method and returns JSON string
  #
  def self.buildArrayFromBundle b
      parse = JSON.parse b.bundle
      bundle = {}
      bundle["id"] = b.id
      bundle["created"] = b.created_at
      bundle["updated"] = b.updated_at
      bundle["name"] = parse["name"]
      bundle["type"] = parse["type"]
      bundle["total"] = 0.00
      bundle["items"] = []

      parse["items"].each do |id,amount|
        item = {}
        i = Item.find (id.to_i)
        item["name"] = i.name
        item["id"] = id
        item["amount"] = amount
        item["price"] = i.preis
        bundle["items"].push item
        bundle["total"] += amount.to_f * i.preis
      end

      return bundle
  end

  #
  # returns array of all ShopBundles and returns ShopBundles with all item information
  #
  def self.getShopBundlesWithItems
    bundles = self.all
    res_bundles = []
    bundles.each do |b|
      bundle = self.buildArrayFromBundle b
      res_bundles.push bundle
    end

    return res_bundles
  end

end
