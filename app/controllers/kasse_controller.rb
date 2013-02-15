# encoding: UTF-8

class KasseController < ApplicationController
  before_filter :authenticate_user!
  before_filter do |controller|
    unless controller.check_role('admin','kassenwart')
      redirect_to root_path, :notice => 'Aktion nicht erlaubt'
    end
  end
  before_filter :set_ag_kontos

  def set_ag_kontos
    @ag_kontos = Konto.ag.order(:name)
  end

  def uebersicht
    @verkaeufer_kontos = Konto.verkaeufer.order(:name)
    @ext_kontos = Konto.ext.order(:name)
  end

  def show_konto
    @konto = Konto.find params[:id]
  end
end
