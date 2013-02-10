# encoding: UTF-8

class ItemsController < ApplicationController
  before_filter :authenticate_user!
  before_filter do |controller|
    unless controller.check_role('admin','lagerwart')
      redirect_to root_path, :notice => 'Aktion nicht erlaubt'
    end
  end

  def index
    @items = Item.order("name")
  end

  def new
    @item = Item.new
    @item.item_prices.build
  end

  def edit
    @item = Item.find(params[:id])
    @item.item_prices.build if @item.item_prices.size < 1
  end

  def show
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update_attributes(params[:item])
      redirect_to(items_path, :notice => 'Artikel erfolgreich editiert.')
    else
      @item.item_prices.build if @item.item_prices.size < 1
      render :edit
    end
  end

  def create
    @item = Item.new params[:item]
    if @item.save
      redirect_to(items_path, :notice => 'Artikel erfolgreich angelegt.')
    else
      @item.item_prices.build if @item.item_prices.size < 1
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

  def get_priceoptions
    item = Item.find params[:id]
    render :text => item.item_prices.map{|p| {p.id =>"#{p.name} (#{view_context.number_to_currency(p.price, :locale => :de)})"}}.to_json and return
  end
end

