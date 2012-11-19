class RenameUserkontoToUserkontoBuchung < ActiveRecord::Migration
  def change
    rename_table :userkontos, :userkonto_buchungs
  end
end
