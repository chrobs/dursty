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
  end

  def edit
    @item = Item.find(params[:id])
  end

  def show
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update_attributes(params[:item])
      redirect_to(items_path, :notice => 'Artikel erfolgreich editiert.')
    else
      render :edit
    end
  end

  def create
    @item = Item.new params[:item]
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

