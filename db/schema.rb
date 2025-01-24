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

ActiveRecord::Schema[7.2].define(version: 2024_12_31_153544) do
  create_table "bots", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "symbol"
    t.string "strategy"
    t.decimal "minimum_balance", precision: 10, scale: 2
    t.decimal "maximum_trade_size", precision: 10, scale: 2
    t.string "status", default: "active"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_bots_on_user_id"
  end

  create_table "payments", force: :cascade do |t|
    t.integer "user_id", null: false
    t.decimal "amount", precision: 10, scale: 2
    t.string "status"
    t.datetime "payment_date"
    t.datetime "expires_at"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_payments_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email", null: false
    t.string "password"
    t.string "password_digest"
    t.string "remember_token"
    t.string "role", default: "user"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "api_key"
    t.string "secret"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["remember_token"], name: "index_users_on_remember_token"
  end

  add_foreign_key "bots", "users"
  add_foreign_key "payments", "users"
end
