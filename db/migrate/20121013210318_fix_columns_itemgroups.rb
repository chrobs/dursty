class FixColumnsItemgroups < ActiveRecord::Migration
  def change
    rename_column :itemgroups, :subitem, :item_id
  end
end
