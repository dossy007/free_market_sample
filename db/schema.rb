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

ActiveRecord::Schema.define(version: 2019_06_19_093143) do

  create_table "items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.integer "size"
    t.string "brand"
    t.integer "shopping_status"
    t.integer "send_burden"
    t.integer "shopping_method"
    t.integer "prefecture"
    t.integer "delivery_date"
    t.integer "price"
    t.text "text"
    t.integer "good_function"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "nickname", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "last_name"
    t.string "first_name"
    t.string "last_kana"
    t.string "first_kana"
    t.string "postal_code"
    t.integer "prefecture_id"
    t.string "city_name"
    t.string "house_number"
    t.string "building_name"
    t.integer "phone_number"
    t.integer "birth_year"
    t.integer "birth_month"
    t.integer "birth_day"
    t.integer "credit_id"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["nickname"], name: "index_users_on_nickname"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
