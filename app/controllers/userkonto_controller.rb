# encoding: UTF-8

class UserkontoController < ApplicationController
  before_filter :authenticate_user!

  def index
    @user = User.find current_user
    orders = Order.closed.where :user_id => current_user
    bills = UserAccountBill.where :user_id => current_user
    @buchungen = (orders + bills).sort!{|a,b| b.updated_at <=> a.updated_at}
    @buchungen = @buchungen.paginate(page:params[:page], per_page:5)
  end

  def edit
  end
end
