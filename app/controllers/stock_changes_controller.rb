# encoding: UTF-8
class StockChangesController < ApplicationController
  before_filter :authenticate_user!
  before_filter do |controller|
    unless controller.check_role('admin','lagerwart') || User.find(params[:id]).id == current_user.id
      redirect_to root_path, :notice => 'Aktion nicht erlaubt'
    end
  end

  def index
    @stock = Stock.find params[:stock]
    @stock_changes = StockChange.where(:stock_id => @stock.id).order("created_at DESC")
  end

  def new
    @stock_change = StockChange.new
    if params[:stock]
      @stock_change[:stock_id] = params[:stock]
    end
    @bundles = ShopBundle.all.map{|b| [b.name+" ("+b.getTotalCost.to_s+")", b.id]}
    @stocks = Stock.all
  end

  def create
    stock_change = StockChange.new params[:stock_change]
    if stock_change.save
      redirect_to stock_changes_path(:stock => stock_change.stock.id), :notice => 'Lageränderung gespeichert.'
    else
      render :new
    end
  end

  def edit
    @stock_change = StockChange.find params[:id]
    @bundles = ShopBundle.all.map{|b| [b.name+" ("+b.getTotalCost.to_s+")", b.id]}
    @stocks = Stock.all
  end

  def update
    stock_change = StockChange.find params[:id]
    if stock_change.update_attributes params[:stock_change]
      redirect_to stock_changes_path(:stock => stock_change.stock.id), :notice => 'Lageränderung gespeichert.'
    else
      render :edit
    end
  end

  def destroy
    stock_change = StockChange.find params[:id]
    if stock_change.destroy
      redirect_to(stock_changes_path(:stock => stock_change.stock.id), :notice => 'Lageränderung erfolgreich gelöscht.')
    else
      redirect_to(stock_changes_path(:stock => stock_change.stock.id), :notice => 'Lageränderung nicht gelöscht.')
    end
  end
end
