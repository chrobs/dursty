class ShopController < ApplicationController
  before_filter :authenticate_user!

  def index
    @bundles = ShopBundle.find :all, :order => :name

    # get information for shopping card
    @order = Order.where(:user_id => current_user.id, :closed => false)
                  .order("updated_at")
                  .last
    @order = Order.new if @order.nil?
  end

  def addToCard
    #get last or new order from user
    @order = Order.where(:user_id => current_user.id, :closed => false)
                  .order("updated_at")
                  .last
    if @order.nil?
      @order = Order.new(:user_id => current_user, :closed => false)
      @order.save
    end

    # add order_part for each item in shop_bundle
    if @order.updateParts(params[:bundle], params[:amount])
      @order.touch
      redirect_to(shop_index_path, :notice => "Erfolgreich in den Wagen gelegt.")
    else
      redirect_to(shop_index_path, :notice => "Fehler aufgetreten, nicht in den wagen geleget.")
    end
  end

  def konto
  end
end
