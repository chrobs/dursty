# encoding: UTF-8

class ShopBundlesController < ApplicationController
  before_filter :authenticate_user!
  before_filter {|controller| controller.check_role('admin','lagerwart') }

  def index
    @bundles = ShopBundle.getShopBundlesWithItems
  end

  def new
    @bundle = ShopBundle.new
  end

  def edit
    b = ShopBundle.find(params[:id])
    @bundle = ShopBundle.buildArrayFromBundle b
  end

  def update
    @bundle = ShopBundle.find(params[:id])
    bundle = ShopBundle.paramsToJson params[:shop_bundle]

    if @bundle.update_attributes( :bundle => bundle.to_s)
      redirect_to(shop_bundles_path, :notice => 'Shop bundle erfolgreich editiert.')
    else
      render :edit
    end
  end

  def create
    @bundle = ShopBundle.new params[:shop_bundle]

    if @bundle.save
      redirect_to(shop_bundles_path, :notice => 'Bundle erfolgreich angelegt.')
    else
      render :new
    end
  end

  def destroy
    @bundle = ShopBundle.find params[:id]
    if @bundle.destroy
      redirect_to(shop_bundles_path, :notice => "Bundle erfolgreich gelöscht.")
    else
      redirect_to(shop_bundles_path, :notice => 'Bundle nicht gelöscht.')
    end
  end

  def show
    render :text => "test" and return
  end

end

