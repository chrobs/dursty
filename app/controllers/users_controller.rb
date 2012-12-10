# encoding: UTF-8
class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter do |controller|
    unless controller.check_role('admin')
      redirect_to root_path, :notice => 'Aktion nicht erlaubt'
    end
  end

  def index
    @users = User.all
  end

  def create
    # create user
    data = params[:user]
    @user = User.new :name => data[:name], :email => data[:email]
    @user.admin = data[:admin] if data[:admin]
    @user.kassenwart = data[:kassenwart] if data[:kassenwart]
    @user.lagerwart = data[:lagerwart] if data[:lagerwart]
    render :new and return unless @user.save

    # create konto for new user
    @konto = Konto.new :name => @user.name, :user_id => @user.id
    if @konto.save
      redirect_to users_path, :notice => 'User angelegt'
    else
      render :new
    end
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find params[:id]
  end

  def show
  end

  def update
    @user = User.find params[:id]

    # update user
    data = params[:user]
    @user.name = data[:name]
    @user.email = data[:email]
    @user.admin = data[:admin] if data[:admin]
    @user.kassenwart = data[:kassenwart] if data[:kassenwart]
    @user.lagerwart = data[:lagerwart] if data[:lagerwart]
    unless @user.save
      redirect_to users_path, :notice => 'User erfolgreich editiert' and return
    end

    # update user konto
    konto = Konto.where(:user_id => @user.id).first_or_create(:user_id => @user.id)
    konto.name = @user.name

    if konto.save
      redirect_to users_path, :notice => 'User erfolgreich editiert'
    else
      render :edit
    end
  end

  def destroy
    user = User.find params[:id]

    # delete user konto
    konto = Konto.where(:user_id => user.id)
    unless konto.exists? && konto.first.destroy
      redirect_to users_path, :notice => 'Fehler beim Löschen des Kontos, User nicht gelöscht.' and return
    end

    # delete user
    if user.destroy
      redirect_to(users_path, :notice => "User & Konto erfolgreich gelöscht.")
    else
      redirect_to(users_path, :notice => 'User nicht gelöscht.')
    end
  end
end
