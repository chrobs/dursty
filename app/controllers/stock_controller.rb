class StockController < ApplicationController
  before_filter :authenticate_user!
  before_filter do |controller|
    unless controller.check_role('admin','lagerwart') || User.find(params[:id]).id == current_user.id
      redirect_to root_path, :notice => 'Aktion nicht erlaubt'
    end
  end

  def index
    @stocks = Stock.all
    @soldBundles = {:from => 4.weeks.ago.beginning_of_day, :to => Time.zone.now.end_of_day}
    @stocks.each do |s|
      @soldBundles[s.id] = s.soldBundles @soldBundles[:from], @soldBundles[:to]
    end
  end

  def sold_bundles
    from = Time.zone.parse(params[:from]).beginning_of_day
    to = Time.zone.parse(params[:to]).end_of_day
    @soldBundles = Stock.find(params[:id]).soldBundles from, to
    render :partial => "stock/soldBundle" and return
  end
end
