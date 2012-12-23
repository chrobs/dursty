class StockController < ApplicationController
  def index
    @stocks = Stock.all
  end
end
