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

ActiveRecord::Schema.define(:version => 20120127003003) do

  create_table "bills", :force => true do |t|
    t.integer  "barcode",                                   :null => false
    t.date     "date"
    t.decimal  "amount",     :precision => 15, :scale => 2
    t.string   "bill_kind",                                 :null => false
    t.integer  "client_id"
    t.text     "items",                                     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bills", ["barcode"], :name => "index_bills_on_barcode", :unique => true

  create_table "boxes", :force => true do |t|
    t.integer  "day"
    t.integer  "month"
    t.integer  "year"
    t.integer  "count",                                     :default => 0
    t.decimal  "total",      :precision => 15, :scale => 2, :default => 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "carts", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.string   "categoria"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["categoria"], :name => "index_categories_on_categoria", :unique => true

  create_table "clients", :force => true do |t|
    t.string   "name",                                                        :null => false
    t.string   "last_name",                                                   :null => false
    t.string   "document",                                                    :null => false
    t.string   "adress"
    t.string   "email"
    t.string   "location"
    t.integer  "phone"
    t.string   "cellphone"
    t.string   "client_kind",                                                 :null => false
    t.string   "bill_kind"
    t.decimal  "amount",      :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "spend",       :precision => 15, :scale => 2, :default => 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "clients", ["document"], :name => "index_clients_on_document", :unique => true
  add_index "clients", ["last_name"], :name => "index_clients_on_last_name"

  create_table "line_items", :force => true do |t|
    t.integer  "product_id"
    t.integer  "cart_id"
    t.integer  "order_id"
    t.decimal  "price",      :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "quantity",   :precision => 15, :scale => 2, :default => 1.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "monthlies", :force => true do |t|
    t.integer  "month"
    t.integer  "year"
    t.decimal  "sold",       :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "bought",     :precision => 15, :scale => 2, :default => 0.0
    t.decimal  "to_pay",     :precision => 15, :scale => 2, :default => 0.0
    t.boolean  "paid",                                      :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", :force => true do |t|
    t.integer  "client_id"
    t.string   "bill_kind"
    t.boolean  "to_amount",                                 :default => false
    t.decimal  "price",      :precision => 15, :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "orders", ["client_id"], :name => "index_orders_on_client_id"

  create_table "products", :force => true do |t|
    t.string   "barcode",                      :null => false
    t.string   "name",                         :null => false
    t.string   "mark"
    t.string   "fragance"
    t.decimal  "price",                        :null => false
    t.decimal  "count",                        :null => false
    t.string   "uni"
    t.decimal  "stock",       :default => 0.0
    t.decimal  "pricedist"
    t.decimal  "iva"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "products", ["barcode"], :name => "index_products_on_barcode", :unique => true
  add_index "products", ["name"], :name => "index_products_on_name"

end
