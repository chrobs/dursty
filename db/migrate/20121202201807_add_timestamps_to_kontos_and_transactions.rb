class AddTimestampsToKontosAndTransactions < ActiveRecord::Migration
  def change
    add_timestamps :kontos
    add_timestamps :konto_transactions
  end
end
