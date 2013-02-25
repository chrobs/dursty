class CreateSaleDates < ActiveRecord::Migration
  def change
    create_table :sale_dates do |t|
      t.datetime :date
      t.integer :user_id

      t.timestamps
    end
  end
end
