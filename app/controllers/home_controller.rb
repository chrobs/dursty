# encoding: UTF-8

class HomeController < ApplicationController
  before_filter :authenticate_user!

  def index
    @user = User.find current_user
  end

end
