# encoding: UTF-8

class ShopController < ApplicationController
  before_filter :authenticate_user!

  before_filter :set_user


  def set_user
    @user = User.find current_user.id
  end

  def index
    if params[:category]
      @bundles = ShopBundle
                .includes(:shop_bundle_categories)
                .where("shop_bundle_categories.id = ?", params[:category])
                .order(["shop_bundles.name ASC","shop_bundles.positive"])
    else
      @bundles = ShopBundle.find :all, :order => :name
    end

    # get information for shopping card
    @order = Order.where(:user_id => current_user.id, :closed => false)
                  .order("updated_at DESC")
                  .first_or_create!(:stock_id => @user.stocks.first.id)
  end

  def addBundleToCard
    #get last or new order from user
    @order = Order.where(:user_id => current_user.id, :closed => false)
                  .order("updated_at DESC")
                  .first_or_create!

    # add order_part for each item in shop_bundle
    if @order.updateParts(params[:bundle], params[:amount])
      @order.touch
      redirect_to(shop_index_path(:category => params[:category]), :notice => "Erfolgreich in den Wagen gelegt.")
    else
      redirect_to(shop_index_path(:category => params[:category]), :notice => "Fehler aufgetreten, nicht in den Wagen geleget.")
    end
  end

  def changeOrderPartItemAmount
    # get last order
    order = Order.where(:user_id => current_user.id, :closed => false).first
    # select order part
    part = order.order_parts.find(params[:order_part])
    if part.updateItem(params[:order_part_item_id], params[:amount])
      part.touch
      redirect_to(shop_index_path(:category => params[:category]), :notice => "Erfolgreich in den Wagen gelegt.")
    else
      redirect_to(shop_index_path(:category => params[:category]), :notice => "Fehler aufgetreten, nicht in den Wagen geleget.")
    end
  end

  def removeBundleFromCard
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
      redirect_to(shop_index_path(:category => params[:category]), :notice => "Erfolgreich aus dem Wagen entfernt.")
    else
      redirect_to(shop_index_path(:category => params[:category]), :notice => "Fehler aufgetreten, nichts aus dem Wagen entfernt.")
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
    order.stock = Stock.find(params[:order][:stock_id])
    order.created_at = Time.zone.now
    if order.save
      redirect_to(shop_index_path, :notice => "Erfolgreich abgerechnet.")
    else
      redirect_to(shop_index_path, :notice => "Fehler aufgetreten. Nichts abgerechnet.")
    end
  end

end
