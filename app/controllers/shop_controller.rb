class ShopController < ApplicationController
  before_filter :authenticate_user!

  def show
    @products = Item.where(:shop => true)
  end

  def konto
  end
end
