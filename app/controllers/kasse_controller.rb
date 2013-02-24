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
    @kasse_uebersicht = []
    @kasse_uebersicht << {:name => :"Verkäuferkonten", :saldo => Konto.verkaeufer.inject(0){|s,k| s+=k.saldo}}
    @kasse_uebersicht << {:name => :"AG-Konten", :saldo => Konto.ag.inject(0){|s,k| s+=k.saldo}}
    @kasse_uebersicht << {:name => :"EXT-Konten", :saldo => Konto.ext.inject(0){|s,k| s+=k.saldo}}
    Stock.all.each do |s|
      @kasse_uebersicht << {:name => :"Lagerwert #{s.name.upcase}", :saldo => s.stock_value}
    end
    @kasse_uebersicht_saldo = @kasse_uebersicht.inject(0){|s,i| s+=i[:saldo]}
  end

  def show_konto
    @konto = Konto.find params[:id]
  end
end
