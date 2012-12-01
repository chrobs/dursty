# encoding: UTF-8

class OrderController < ApplicationController
  before_filter :authenticate_user!
  before_filter do |controller|
    unless controller.check_role('admin','kassenwart') || Order.find(params[:id]).user_id == current_user.id
      redirect_to(userkonto_index_path, :notice => 'Aktion nicht erlaubt.')
    end
  end

  def edit
    @order = Order.find params[:id]
  end

  def update_bundle_amount
    @order = Order.find params[:id]
    if @order.updateParts params[:bundle], params[:amount]
      @order.touch
      redirect_to(edit_order_path(@order.id), :notice => "Bestellung erfolgreich geändert.")
    else
      redirect_to(edit_order_path(@order.id), :notice => "Fehler aufgetreten, Bestellung nicht geändert.")
    end

  end

  def delete_bundle
    @order = Order.find params[:id]
    if @order.removePart(params[:bundle])

      # check if order is empty now, then remove order
      unless @order.order_parts.size > 0
        @order.delete
        redirect_to(userkonto_show_path(@order.user_id), :notice => "Bestellung gelöscht.")
      else
        @order.touch
        redirect_to(edit_order_path(@order.id), :notice => "Erfolgreich aus der Bestellung entfernt.")
      end

    else
      redirect_to(edit_order_path(@order.id), :notice => "Fehler aufgetreten, nichts aus der Bestellung entfernt.")
    end

  end
end
