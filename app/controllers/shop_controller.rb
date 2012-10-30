class ShopController < ApplicationController
  before_filter :authenticate_user!

  def index
    @bundles = ShopBundle.getShopBundlesWithItems
  end

  def buy
    @order = current_user.orders
    render :text => @order.count and return
  end

  def konto
  end
end
