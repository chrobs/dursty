class Konto < ActiveRecord::Base
  attr_accessible :name

  has_many :transactions_out, :class_name => "KontoTransaction", :foreign_key => :from
  has_many :transactions_in, :class_name => "KontoTransaction", :foreign_key => :to
  belongs_to :user

  @@bar_konto_id = 1
  @@ec_konto_id = 2

  def self.ag_kontos
    k = []
    k.append self.find @@bar_konto_id
    k.append self.find @@ec_konto_id
    return k
  end

  def self.verkaeufer_kontos
    k = []
    user = User.all
    user.each{|u| k.append u.konto}
    return k
  end

  def self.bar_konto
    return self.find @@bar_konto_id
  end

  def self.ec_konto
    return self.find @@ec_konto_id
  end

  def saldo
    saldo = 0
    saldo = self.transactions_in.inject(saldo){|s,t| s + t.price}
    saldo = self.transactions_out.inject(saldo){|s,t| s - t.price}
    return saldo
  end

  def transactions limit=nil
    res = self.transactions_in.limit(limit) + self.transactions_out.limit(limit)
    res.sort!{|a,b| b.created_at <=> a.created_at}
    return res
  end
end
