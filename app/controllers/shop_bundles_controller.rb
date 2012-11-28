# encoding: UTF-8

class ShopBundlesController < ApplicationController
  before_filter :authenticate_user!
  before_filter do |controller|
    unless controller.check_role('admin','lagerwart')
      redirect_to root_path, :notice => 'Aktion nicht erlaubt'
    end
  end

  def index
    @bundles = ShopBundle.find(:all, :order => :name)
  end

  def new
    @bundle = ShopBundle.new
  end

  def edit
    @bundle = ShopBundle.find(params[:id])
  end

  def update
    @bundle = ShopBundle.find(params[:id])
    #render :text => @bundle.id and return

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
    unless @bundle.shop_bundle_parts.destroy_all
      redirect_to(shop_bundles_path, :notice => 'Bundle-Parts nicht komplett gelöscht.')
    end
    unless @bundle.destroy
      redirect_to(shop_bundles_path, :notice => 'Bundle nicht gelöscht.')
    end
    redirect_to(shop_bundles_path, :notice => "Bundle erfolgreich gelöscht.")
  end

  def show
    render :text => "test" and return
  end

end

