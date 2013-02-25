# encoding: UTF-8
class SaleDateController < ApplicationController
  before_filter :authenticate_user!

  def index
    @dates = {}

    dates = SaleDate.next_dates

    # if next sale date not tuesday, fill in mock date
    if dates.first.date.cwday != 2
      @dates[dates.first.date.cweek] = []
      @dates[dates.first.date.cweek] << nil
    end

    dates.each do |d|
      @dates[d.date.cweek] = [] unless @dates[d.date.cweek]
      @dates[d.date.cweek] << d
    end
  end

  def assign
    date = SaleDate.find(params[:id])

    # check if user is permitted to change assignment
    unless params[:userid].to_i == current_user.id
      redirect_to(sale_date_index_path, :notice => 'Fehler aufgetreten, falscher Benutzer.') and return
    end

    date.user_id = params[:userid]
    if date.save
      redirect_to(sale_date_index_path, :notice => 'Erfolgreich zu Termin zugeordnet.')
    else
      redirect_to(sale_date_index_path, :notice => 'Fehler aufgetreten, keinem Termin zugeordnet.')
    end
  end

  def unassign
    date = SaleDate.find(params[:id])

    # check if user is permitted to change assignment
    unless params[:userid].to_i == current_user.id
      redirect_to(sale_date_index_path, :notice => 'Fehler aufgetreten, falscher Benutzer.') and return
    end

    date.user_id = nil
    if date.save
      redirect_to(sale_date_index_path, :notice => 'Verkaufsterminzuordnung erfolgreich gelöscht.')
    else
      redirect_to(sale_date_index_path, :notice => 'Fehler aufgetreten, Verkaufstermin weiterhin zugeordnet.')
    end
  end
end
