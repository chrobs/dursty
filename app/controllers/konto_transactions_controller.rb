# encoding: UTF-8

class KontoTransactionsController < ApplicationController
  before_filter :authenticate_user!
  before_filter do |controller|
    unless controller.check_role('admin','kassenwart')
      redirect_to root_path, :notice => 'Aktion nicht erlaubt'
    end
  end

  before_filter :set_ag_kontos

  def set_ag_kontos
    @ag_kontos = Konto.ag
  end

  def create
    transact = KontoTransaction.new params[:konto_transaction]
    if transact.save
      redirect_to(konto_path(transact.from), :notice => 'Transaktion erfolgreich angelegt.')
    else
      render :new
    end
  end

  def new
    @kontos = Konto.ag
    @kontos += Konto.ext
    @kontos += Konto.verkaeufer
    @konto_transaction = KontoTransaction.new(:from => params[:from])
  end

  def edit
    @konto_transaction = KontoTransaction.find params[:id]
    @kontos = Konto.ag
    @kontos += Konto.ext
    @kontos += Konto.verkaeufer
  end

  def show
    @konto_transaction = KontoTransaction.find params[:id]
  end

  def update
    transact = KontoTransaction.find params[:id]
    if transact.update_attributes(params[:konto_transaction])
      redirect_to(konto_path(transact.from), :notice => 'Transaktion erfolgreich editiert.')
    else
      render :edit
    end
  end

  def destroy
    transact = KontoTransaction.find params[:id]
    if transact.destroy
      redirect_to(konto_path(transact.from), :notice => 'Transaktion erfolgreich gelöscht.')
    else
      redirect_to(konto_path(transact.from), :notice => 'Transaktion nicht gelöscht.')
    end
  end
end
