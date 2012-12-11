class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable,
  # :validatable and :omniauthable, :registerable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable,
         :timeoutable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :tvk, :oph
  # attr_accessible :title, :body
  validates_presence_of :name, :email
  validates_uniqueness_of :name, :email, :case_sensitive => false

  has_many :orders
  has_many :user_account_bills
  has_one :konto

  def gesSaldo
    saldo = ordersSaldo
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

  def sell_locations
    loc = []
    loc.append :oph if self.oph
    loc.append :tvk if self.tvk
  end
end
