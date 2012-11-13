# encoding: UTF-8

class ShopBundlesController < ApplicationController
  before_filter :authenticate_user!
  before_filter {|controller| controller.check_role('admin','lagerwart') }

  def index
    @bundles = ShopBundle.all
  end

  def new
    @bundle = ShopBundle.new
  end

  def edit
    @bundle = ShopBundle.find(params[:id])
  end

  def update
    @bundle = ShopBundle.find(params[:id])
    #render :text => params.inspect and return

    render :edit unless @bundle.update_attributes( :name => params[:shop_bundle][:name], :positive => params[:shop_bundle][:positive])

    render :edit unless @bundle.shop_bundle_parts.destroy_all
    render :edit unless ShopBundlePart.newFromBundleParams params

    redirect_to(shop_bundles_path, :notice => 'Shop bundle erfolgreich editiert.')
  end

  def create

    #render :text => params[:shop_bundle].inspect and return
    @bundle = ShopBundle.new :name => params[:shop_bundle][:name], :positive => params[:shop_bundle][:positive]

    render :new unless @bundle.save
    params[:id] = @bundle.id
    render :new unless ShopBundlePart.newFromBundleParams params

    redirect_to(shop_bundles_path, :notice => 'Bundle erfolgreich angelegt.')
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

