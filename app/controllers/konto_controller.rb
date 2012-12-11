class KontoController < ApplicationController
  before_filter :authenticate_user!
  before_filter do |controller|
    unless controller.check_role('admin', 'kassenwart')
      redirect_to root_path, :notice => 'Aktion nicht erlaubt'
    end
  end

  before_filter :set_ag_kontos

  def set_ag_kontos
    @ag_kontos = Konto.ag
  end


  def index
    @kontos = Konto.all
  end

  def new
  end

  def create
  end

  def show
    @konto = Konto.find params[:id]
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
