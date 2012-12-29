class StockController < ApplicationController
  before_filter :authenticate_user!
  before_filter do |controller|
    unless controller.check_role('admin','lagerwart') || User.find(params[:id]).id == current_user.id
      redirect_to root_path, :notice => 'Aktion nicht erlaubt'
    end
  end

  def index
    @stocks = Stock.all
  end
end
