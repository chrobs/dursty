class UserkontoController < ApplicationController
  before_filter :authenticate_user!

  def index
    @user = User.find current_user
    orders = Order.closed.where :user_id => current_user
    bills = UserAccountBill.where :user_id => current_user
    @buchungen = (orders + bills).sort!{|a,b| b.created_at <=> a.created_at}
  end

  def edit
  end
end
