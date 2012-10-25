# encoding: UTF-8

class ShopBundlesController < ApplicationController
  before_filter :authenticate_user!
  before_filter {|controller| controller.check_role('admin','lagerwart') }

  def index
    @bundles = ShopBundle.all
    render :text => @bundles.inspect and return
  end

  def new
    @bundle = ShopBundle.new
  end

  def edit
    @bundle = ShopBundle.find(params[:id])
  end

  def update
    @bundle = ShopBundle.find(params[:id])
    if @bundle.update_attributes(params[:item])
      redirect_to(items_path, :notice => 'Artikel erfolgreich editiert.')
    else
      render :edit
    end
  end

  def create
    render :text => params.inspect and return
    @bundle= ShopBundle.new params[:shop_bundle]
    if @item.save
      redirect_to(items_path, :notice => 'Artikel erfolgreich angelegt.')
    else
      render :new
    end
  end

  def destroy
    @item = Item.find params[:id]
    if @item.destroy
      redirect_to(items_path, :notice => "Artikel erfolgreich gelöscht.")
    else
      redirect_to(items_path, :notice => 'Artikel nicht gelöscht.')
    end
  end
end

