class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable,
  # :validatable and :omniauthable, :registerable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable,
         :timeoutable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :tvk, :oph, :room
  # attr_accessible :title, :body
  validates_presence_of :name, :email
  validates_uniqueness_of :name, :email, :case_sensitive => false

  has_many :orders
  has_many :user_account_bills
  has_many :sale_dates
  has_one :konto
  has_and_belongs_to_many :stocks

  def gesSaldo
    saldo = self.konto.initial
    saldo += ordersSaldo
    saldo += self.konto.saldoTransactions
  end

  def ordersSaldo
    saldo = self.orders.inject(0.0) do |s,order|
      if order.closed
        s + order.gesamtpreis
      else
        s
      end
    end
    return saldo
  end

  def set_stocks st_ids
    st_ids.reject!{|i| i.empty?}
    self.stocks = st_ids.map{|sid| Stock.find sid}
  end
end
