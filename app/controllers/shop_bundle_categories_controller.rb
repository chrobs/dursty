# encoding: UTF-8

class ShopBundleCategoriesController < ApplicationController
  def index
    @categories = ShopBundleCategory.all
  end

  def new
    @category = ShopBundleCategory.new
  end

  def create
    @category = ShopBundleCategory.new params[:shop_bundle_category]
    if @category.save
      redirect_to(shop_bundle_categories_path, :notice => 'Kategorie angelegt.')
    else
      render :new and return
    end
  end

  def edit
    @category = ShopBundleCategory.find params[:id]
  end

  def update
    @category = ShopBundleCategory.find params[:id]
    if @category.update_attributes params[:shop_bundle_category]
      redirect_to(shop_bundle_categories_path, :notice => 'Kategorie geändert.')
    else
      render :edit and return
    end
  end

  def destroy
    @category = ShopBundleCategory.find params[:id]
    if @category.destroy
      redirect_to(shop_bundle_categories_path, :notice => 'Kategorie gelöscht.')
    else
      redirect_to(shop_bundle_categories_path, :notice => 'Kategorie nicht gelöscht.')
    end
  end
end
