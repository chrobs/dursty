class OrderController < ApplicationController
  before_filter :authenticate_user!
  before_filter do |controller|
    unless controller.check_role('admin','kassenwart') || Order.find(params[:id]).user_id == current_user.id
      redirect_to(userkonto_index_path, :notice => 'Aktion nicht erlaubt.')
    end
  end

  def edit
    render :text => "test" and return
    @order = Order.find params[:id]
  end

  def update
  end

  def destroy
  end
end
