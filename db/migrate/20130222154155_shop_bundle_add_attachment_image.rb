class ShopBundleAddAttachmentImage < ActiveRecord::Migration
  def change
    add_attachment :shop_bundles, :image
  end
end
