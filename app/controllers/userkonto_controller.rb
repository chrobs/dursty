# encoding: UTF-8

class UserkontoController < ApplicationController
  before_filter :authenticate_user!
  before_filter do |controller|
    unless controller.check_role('admin','kassenwart') || User.find(params[:id]).id == current_user.id
      redirect_to root_path, :notice => 'Aktion nicht erlaubt'
    end
  end

  def show
    @user = User.find params[:id]
    orders = Order.closed.where :user_id => params[:id]
    transactions = @user.konto.transactions
    @buchungen = (orders + transactions).sort!{|a,b| b.created_at <=> a.created_at}
    @buchungen << KontoTransaction.new(:to => @user.konto.id,
                    :name => "Initialwert", :price => @user.konto.initial)
    @buchungen = @buchungen.paginate(page:params[:page], per_page:10)
  end

  def edit
  end
end
