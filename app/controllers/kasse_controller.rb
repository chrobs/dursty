# encoding: UTF-8

class KasseController < ApplicationController
  before_filter :authenticate_user!
  before_filter do |controller|
    unless controller.check_role('admin','kassenwart')
      redirect_to root_path, :notice => 'Aktion nicht erlaubt'
    end
  end

  def uebersicht
    @bar_konto = Konto.bar_konto
    @ec_konto = Konto.ec_konto
  end

  def bar_konto
    @konto = Konto.bar_konto
    render "kasse/konto.html.haml"
  end

  def ec_konto
    @konto = Konto.ec_konto
    render "kasse/konto.html.haml"
  end
end
