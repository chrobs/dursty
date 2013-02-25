class ChangeDateTypeFromDateTimeToDateInSaleDates < ActiveRecord::Migration
  def change
    change_column :sale_dates, :date, :date
  end
end
