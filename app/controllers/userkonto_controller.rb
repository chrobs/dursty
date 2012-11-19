class UserkontoController < ApplicationController
  def index
    @user = User.find current_user
    @orders = @user.orders.where(:closed => true)
                   .order("updated_at DESC")
  end

  def edit
  end
end
