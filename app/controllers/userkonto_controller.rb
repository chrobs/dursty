# encoding: UTF-8

class UserkontoController < ApplicationController
  before_filter :authenticate_user!
  before_filter do |controller|
    unless controller.check_role('admin','kassenwart') || User.find(params[:id]).id == current_user.id
      redirect_to root_path, :notice => 'Aktion nicht erlaubt'
    end
  end

  def show
    @user = User.find current_user
    orders = Order.closed.where :user_id => current_user
    bills = UserAccountBill.where :user_id => current_user
    @buchungen = (orders + bills).sort!{|a,b| b.created_at <=> a.created_at}
    @buchungen = @buchungen.paginate(page:params[:page], per_page:10)
  end

  def edit
  end
end
