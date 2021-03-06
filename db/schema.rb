# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130227102521) do

  create_table "item_prices", :force => true do |t|
    t.string   "name"
    t.decimal  "price",      :precision => 8, :scale => 2, :default => 0.0
    t.integer  "item_id"
    t.datetime "created_at",                                                :null => false
    t.datetime "updated_at",                                                :null => false
  end

  create_table "items", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "konto_transactions", :force => true do |t|
    t.integer  "from"
    t.integer  "to"
    t.string   "name"
    t.decimal  "price",      :precision => 8, :scale => 2, :default => 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "kontos", :force => true do |t|
    t.string   "name",                                                        :null => false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "ext",                                      :default => false
    t.boolean  "ag",                                       :default => false
    t.decimal  "initial",    :precision => 8, :scale => 2, :default => 0.0,   :null => false
  end

  create_table "order_part_items", :force => true do |t|
    t.integer  "order_part_id"
    t.integer  "item_id"
    t.integer  "amount"
    t.decimal  "price",         :precision => 8, :scale => 2, :default => 0.0
    t.string   "name"
    t.datetime "created_at",                                                   :null => false
    t.datetime "updated_at",                                                   :null => false
  end

  create_table "order_parts", :force => true do |t|
    t.integer  "order_id"
    t.integer  "shop_bundle_id"
    t.integer  "amount"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.boolean  "positive",       :default => true
    t.string   "name"
  end

  create_table "orders", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.boolean  "closed",     :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "stock_id"
  end

  create_table "sale_dates", :force => true do |t|
    t.date     "date"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "shop_bundle_categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "shop_bundle_categories_shop_bundles", :force => true do |t|
    t.integer "shop_bundle_id"
    t.integer "shop_bundle_category_id"
  end

  create_table "shop_bundle_parts", :force => true do |t|
    t.integer  "shop_bundle_id"
    t.integer  "item_id"
    t.integer  "amount"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "item_price_id"
  end

  create_table "shop_bundles", :force => true do |t|
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.text     "name",               :null => false
    t.boolean  "positive"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "stock_changes", :force => true do |t|
    t.integer  "shop_bundle_id"
    t.integer  "amount"
    t.string   "name"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "stock_id"
  end

  create_table "stocks", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "stocks_users", :force => true do |t|
    t.integer "stock_id"
    t.integer "user_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",                                                             :null => false
    t.string   "encrypted_password",     :default => "$2a$10$cbAQQyQlgX6Iljl4wfT3ueciZvsjeEwlZp6fgizvzYXtpwqnLwyPW", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                                                                         :null => false
    t.datetime "updated_at",                                                                                         :null => false
    t.string   "name"
    t.boolean  "admin"
    t.boolean  "kassenwart"
    t.boolean  "lagerwart"
    t.string   "room"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
