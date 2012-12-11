# encoding: UTF-8

class KontosController < ApplicationController
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
    @kontos = Konto.all(:order => [:ag, :ext]).reverse
  end

  def new
    @konto = Konto.new
  end

  def create
    @konto = Konto.new params[:konto]
    if @konto.save
      redirect_to(kontos_path, :notice => 'Konto erfolgreich angelegt.')
    else
      render :new and return
    end
  end

  def show
    @konto = Konto.find params[:id]
  end

  def edit
    @konto = Konto.find params[:id]
  end

  def update
    @konto = Konto.find params[:id]
    if @konto.update_attributes(params[:konto])
      redirect_to(kontos_path, :notice => 'Artikel erfolgreich editiert.')
    else
      render :edit and return
    end

  end

  def destroy
    @konto = Konto.find params[:id]
    if @konto.destroy
      redirect_to(kontos_path, :notice => "Konto erfolgreich gelöscht.")
    else
      redirect_to(kontos_path, :notice => 'Konto nicht gelöscht.')
    end
  end
end
