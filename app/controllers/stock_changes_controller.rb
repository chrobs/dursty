class StockChangesController < ApplicationController
  before_filter :authenticate_user!
  before_filter do |controller|
    unless controller.check_role('admin','lagerwart') || User.find(params[:id]).id == current_user.id
      redirect_to root_path, :notice => 'Aktion nicht erlaubt'
    end
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
