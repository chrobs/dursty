class ShopController < ApplicationController
  before_filter :authenticate_user!

  def index
    @bundles = ShopBundle.getShopBundlesWithItems
    @order = Order.where(:user_id => current_user.id, :closed => false)
      .order("updated_at")
      .last
  end

  def buy
    @order = current_user.orders
    render :text => @order.count and return
  end

  def konto
  end
end
