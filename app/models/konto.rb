class Konto < ActiveRecord::Base
  attr_accessible :name

  has_many :transactions_out, :class_name => "KontoTransaction", :foreign_key => :from
  has_many :transactions_in, :class_name => "KontoTransaction", :foreign_key => :to
  belongs_to :user

  @@bar_konto_id = 1
  @@ec_konto_id = 2

  def self.bar_konto
    return self.find @@bar_konto_id
  end

  def self.ec_konto
    return self.find @@ec_konto_id
  end
end
