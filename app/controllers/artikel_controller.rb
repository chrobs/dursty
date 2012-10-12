class ArtikelController < ApplicationController
  before_filter :authenticate_user!
  before_filter {|controller| controller.check_role('admin','lagerwart') }

  def list
    @artikel = Artikel.all
  end

  def new
    @artikel = Artikel.new
  end

  def edit
  end
end
