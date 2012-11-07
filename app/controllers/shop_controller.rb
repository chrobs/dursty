class ShopController < ApplicationController
  before_filter :authenticate_user!

  def index
    @bundles = ShopBundle.getShopBundlesWithItems
    @order = Order.where "user_id = ? AND closed = ?", current_user.id, false
    render :text => @order.size and return
  end

  def buy
    @order = current_user.orders
    render :text => @order.count and return
  end

  def konto
  end
end
