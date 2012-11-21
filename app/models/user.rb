class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable,
  # :validatable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :timeoutable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body
  validates_presence_of :name
  validates_uniqueness_of :name, :email, :case_sensitive => false

  has_many :orders
  has_many :user_account_bills

  def kontoSaldo
    saldo = self.orders.inject(0.0) do |s,order|
      if order.closed
        s + order.gesamtpreis
      else
        s
      end
    end

    saldo = self.user_account_bills.inject(saldo){|s,k| s + k.price}

    return saldo
  end
end
