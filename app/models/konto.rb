class Konto < ActiveRecord::Base
  attr_accessible :name, :user_id

  has_many :transactions_out, :class_name => "KontoTransaction", :foreign_key => :from
  has_many :transactions_in, :class_name => "KontoTransaction", :foreign_key => :to
  belongs_to :user

  scope :ag, where(:ag => true)
  scope :ext, where(:ext => true)
  scope :verkaeufer, where(:ag => false, :ext => false)

  @@bar_konto_id = 1
  @@ec_konto_id = 2

  def self.bar_konto
    return self.find @@bar_konto_id
  end

  def self.ec_konto
    return self.find @@ec_konto_id
  end

  def saldoTransactions
    saldo = self.transactions_in.inject(0){|s,t| s + t.price}
    saldo = self.transactions_out.inject(saldo){|s,t| s - t.price}
    return saldo
  end

  def saldo
    saldo = saldoTransactions
    if self.user
      saldo += self.user.ordersSaldo
    end
    return saldo
  end

  def transactions limit=nil
    res = self.transactions_in.limit(limit) + self.transactions_out.limit(limit)
    res.sort!{|a,b| b.created_at <=> a.created_at}
    return res
  end
end


class ActiveRecord::Relation
  def multSaldo
    return self.inject(0){|s,k| s+=k.saldo}
  end
end
