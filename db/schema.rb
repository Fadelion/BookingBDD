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

ActiveRecord::Schema[8.0].define(version: 2025_05_15_215009) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "accomodations", force: :cascade do |t|
    t.integer "numb_beds"
    t.decimal "price_night"
    t.text "description"
    t.boolean "wifi"
    t.text "welcome_word"
    t.bigint "city_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_accomodations_on_city_id"
    t.index ["user_id"], name: "index_accomodations_on_user_id"
  end

  create_table "bookings", force: :cascade do |t|
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.decimal "amount_total", precision: 10, scale: 2, null: false
    t.bigint "accomodation_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["accomodation_id", "start_date", "end_date"], name: "index_bookings_on_accomodation_id_and_start_date_and_end_date"
    t.index ["accomodation_id"], name: "index_bookings_on_accomodation_id"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_cities_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "telephone"
    t.text "description_profil"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "accomodations", "cities"
  add_foreign_key "accomodations", "users"
  add_foreign_key "bookings", "accomodations", on_delete: :restrict
  add_foreign_key "bookings", "users", on_delete: :restrict
end
