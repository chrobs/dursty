class StockController < ApplicationController
  def index
    @stock = {}
    @stock[:oph] = (StockChange.oph + Order.oph).sort!{|a,b| b.created_at <=> a.created_at}
    @stock[:tvk] = (StockChange.tvk + Order.tvk).sort!{|a,b| b.created_at <=> a.created_at}
  end
end
