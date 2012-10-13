class ItemsController < ApplicationController
  before_filter :authenticate_user!
  before_filter {|controller| controller.check_role('admin','lagerwart') }

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
    @subitems = Itemgroup.where(:main_item => params[:id])
    puts @subitems.inspect
  end

  def update
    @item = Item.find(params[:id])
    if @item.update_attributes(params[:item])
      redirect_to(@item, :notice => 'Artikel erfolgreich editiert.')
    else
      render :edit
    end
  end

  def create
    @item = Item.new params[:item]
    if @item.save
      redirect_to(@item, :notice => 'Artikel erfolgreich angelegt.')
    else
      render :new
    end
  end
end

