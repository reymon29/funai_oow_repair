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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_06_27_121831) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "images", force: :cascade do |t|
    t.string "image"
    t.bigint "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_images_on_order_id"
  end

  create_table "notes", force: :cascade do |t|
    t.text "comment"
    t.bigint "order_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_notes_on_order_id"
    t.index ["user_id"], name: "index_notes_on_user_id"
  end

  create_table "open_calls", force: :cascade do |t|
    t.string "case_no"
    t.string "first_name"
    t.string "last_name"
    t.string "address"
    t.string "address2"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "telephone_no"
    t.string "email"
    t.boolean "called_back", default: false
    t.string "status"
    t.string "serial_number"
    t.text "symptom"
    t.bigint "product_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_open_calls_on_product_id"
    t.index ["user_id"], name: "index_open_calls_on_user_id"
  end

  create_table "order_items", force: :cascade do |t|
    t.bigint "order_id"
    t.bigint "repair_rate_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_items_on_order_id"
    t.index ["repair_rate_id"], name: "index_order_items_on_repair_rate_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "order_no", default: 1000
    t.string "first_name"
    t.string "last_name"
    t.string "address"
    t.string "address2"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "telephone_no"
    t.string "email"
    t.string "order_status"
    t.integer "amount_cents", default: 0, null: false
    t.integer "paid_cents", default: 0, null: false
    t.bigint "product_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "serial_number"
    t.string "case_no"
    t.text "symptom"
    t.boolean "bap_ship", default: false
    t.index ["product_id"], name: "index_orders_on_product_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "payments", force: :cascade do |t|
    t.string "state"
    t.integer "amount_cents", default: 0, null: false
    t.jsonb "payment"
    t.bigint "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_payments_on_order_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "brand"
    t.string "model_no"
    t.string "product_type"
    t.decimal "weight", precision: 4, scale: 2, default: "0.0"
    t.decimal "length", precision: 4, scale: 2, default: "0.0"
    t.decimal "width", precision: 4, scale: 2, default: "0.0"
    t.decimal "height", precision: 4, scale: 2, default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "receivings", force: :cascade do |t|
    t.string "model_no"
    t.string "serial_number"
    t.string "receive_courier"
    t.string "receive_tracking"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "order_id"
    t.index ["order_id"], name: "index_receivings_on_order_id"
  end

  create_table "repair_rates", force: :cascade do |t|
    t.string "category"
    t.string "sku"
    t.string "name"
    t.integer "price_cents", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "repairs", force: :cascade do |t|
    t.string "status"
    t.text "comment"
    t.bigint "order_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_repairs_on_order_id"
    t.index ["user_id"], name: "index_repairs_on_user_id"
  end

  create_table "shippings", force: :cascade do |t|
    t.string "shipout_courier"
    t.string "shipout_tracking"
    t.bigint "order_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "label"
    t.string "name"
    t.boolean "ready_ship", default: false
    t.string "shipping_amount"
    t.index ["order_id"], name: "index_shippings_on_order_id"
    t.index ["user_id"], name: "index_shippings_on_user_id"
  end

  create_table "user_onlines", force: :cascade do |t|
    t.boolean "active"
    t.string "status"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_onlines_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "dept"
    t.string "location"
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "images", "orders"
  add_foreign_key "notes", "orders"
  add_foreign_key "notes", "users"
  add_foreign_key "open_calls", "products"
  add_foreign_key "open_calls", "users"
  add_foreign_key "order_items", "orders"
  add_foreign_key "order_items", "repair_rates"
  add_foreign_key "orders", "products"
  add_foreign_key "orders", "users"
  add_foreign_key "payments", "orders"
  add_foreign_key "receivings", "orders"
  add_foreign_key "repairs", "orders"
  add_foreign_key "repairs", "users"
  add_foreign_key "shippings", "orders"
  add_foreign_key "shippings", "users"
  add_foreign_key "user_onlines", "users"
end
