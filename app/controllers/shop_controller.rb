# encoding: UTF-8

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
      redirect_to(shop_index_path, :notice => "Fehler aufgetreten, nicht in den Wagen geleget.")
    end
  end

  def removeFromCard
    # get last order from user or die
    @order = Order.where(:user_id => current_user.id, :closed => false)
                  .order("updated_at")
                  .last
    if @order.nil?
      redirect_to(shop_index_path, :notice => "Fehler aufgetreten, keine offene Bestellung vorhanden.")
    end

    # remove bundle from order_parts
    if @order.removePart(params[:bundle])
      @order.touch
      redirect_to(shop_index_path, :notice => "Erfolgreich aus dem Wagen entfernt.")
    else
      redirect_to(shop_index_path, :notice => "Fehler aufgetreten, nichts aus dem Wagen entfernt.")
    end
  end

  def buy
    # get information for shopping card
    order = Order.where(:user_id => current_user.id, :closed => false)
                  .order("updated_at")

    if order.size > 1
      redirect_to(shop_index_path, :notice => "Fehler: mehrere Order vorhanden. Nicht abgerechnet.")
    elsif order.size < 1
      redirect_to(shop_index_path, :notice => "Keine Order vorhanden. Nichts abgerechnet.")
    end

    order = order.first
    order.closed = true
    if order.save
      redirect_to(shop_index_path, :notice => "Erfolgreich abgerechnet.")
    else
      redirect_to(shop_index_path, :notice => "Fehler aufgetreten. Nichts abgerechnet.")
    end
  end

end
