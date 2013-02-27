# encoding: UTF-8

class PublicController < ApplicationController
  def index
  end

  def sale_dates
    @dates = SaleDate.next_dates
  end

  def sale_dates_display
    @dates = SaleDate.next_dates
  end
end
