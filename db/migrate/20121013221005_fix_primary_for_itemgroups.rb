class FixPrimaryForItemgroups < ActiveRecord::Migration
  def change
    add_column :itemgroups, :main_item, :integer
  end
end
