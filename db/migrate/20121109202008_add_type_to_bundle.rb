class AddTypeToBundle < ActiveRecord::Migration
  def change
    add_column :shop_bundles, :type, :boolean
  end
end
