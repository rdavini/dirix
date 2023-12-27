# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_12_27_221148) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", primary_key: "order_id", force: :cascade do |t|
    t.string "street"
    t.integer "number"
    t.string "block"
    t.string "city"
    t.string "state", limit: 2
    t.decimal "zip", precision: 8
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_addresses_on_order_id"
    t.check_constraint "number > 0", name: "check_number_ge_zero"
  end

  create_table "api_keys", primary_key: "user_id", force: :cascade do |t|
    t.string "ip"
    t.string "token", null: false
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_api_keys_on_user_id"
  end

  create_table "drivers", primary_key: "user_id", force: :cascade do |t|
    t.string "drivers_license_photo", limit: 300
    t.string "vehicle_doc_photo", limit: 300
    t.string "license_plate"
    t.string "vehicle_brand"
    t.string "vehicle_color"
    t.integer "number_rides_canceled", default: 0
    t.integer "avg_speed", default: 0
    t.boolean "working", default: false
    t.boolean "drivers_license_approved", default: false
    t.boolean "vehicle_doc_approved", default: false
    t.bigint "organization_id", null: false
    t.index ["organization_id"], name: "index_drivers_on_organization_id"
    t.index ["user_id"], name: "index_drivers_on_user_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "code"
    t.bigint "organization_id", null: false
    t.date "start_time"
    t.date "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_orders_on_organization_id"
  end

  create_table "organizations", primary_key: "user_id", force: :cascade do |t|
    t.index ["user_id"], name: "index_organizations_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "phone", limit: 25
    t.string "photo", limit: 300
    t.integer "role", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "model"
    t.string "branch"
    t.string "color"
    t.string "license_plate"
    t.string "vehicle_doc_photo"
    t.bigint "organization_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_vehicles_on_organization_id"
  end

  create_table "working_days", primary_key: ["driver_id", "date"], force: :cascade do |t|
    t.date "date", null: false
    t.datetime "start_time", precision: nil
    t.datetime "last_login", precision: nil
    t.time "total_time", default: "2000-01-01 00:00:00"
    t.integer "number_rides_canceled", default: 0
    t.integer "number_rides", default: 0
    t.decimal "total_revenue", default: "0.0"
    t.bigint "driver_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["driver_id"], name: "index_working_days_on_driver_id"
  end

  add_foreign_key "addresses", "orders", on_delete: :cascade
  add_foreign_key "api_keys", "users", on_delete: :cascade
  add_foreign_key "drivers", "organizations", primary_key: "user_id", on_delete: :cascade
  add_foreign_key "drivers", "users", on_delete: :cascade
  add_foreign_key "orders", "organizations", primary_key: "user_id", on_delete: :cascade
  add_foreign_key "organizations", "users", on_delete: :cascade
  add_foreign_key "vehicles", "organizations", primary_key: "user_id", on_delete: :cascade
  add_foreign_key "working_days", "drivers", primary_key: "user_id", on_delete: :cascade
end
