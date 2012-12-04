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
    @ag_kontos = Konto.ag_kontos
  end

  def uebersicht
    @ag_kontos_saldo = @ag_kontos.inject(0){|s,k| s+=k.saldo}

    @verkaeufer_kontos = Konto.verkaeufer_kontos
    @verkaeufer_kontos_saldo = @verkaeufer_kontos.inject(0){|s,k| s+=k.saldo}
  end

  def show_konto
    @konto = Konto.find params[:id]
  end
end
