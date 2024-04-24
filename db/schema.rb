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

ActiveRecord::Schema[7.1].define(version: 2024_04_23_175026) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bookings", force: :cascade do |t|
    t.integer "number"
    t.date "date"
    t.string "time"
    t.integer "ticket_number"
    t.string "sales_channel"
    t.bigint "event_id", null: false
    t.bigint "pricing_id", null: false
    t.bigint "purchaser_id", null: false
    t.bigint "show_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "imported_file_id"
    t.index ["event_id"], name: "index_bookings_on_event_id"
    t.index ["imported_file_id"], name: "index_bookings_on_imported_file_id"
    t.index ["pricing_id"], name: "index_bookings_on_pricing_id"
    t.index ["purchaser_id"], name: "index_bookings_on_purchaser_id"
    t.index ["show_id"], name: "index_bookings_on_show_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.date "starting_date"
    t.date "ending_date"
    t.string "starting_time"
    t.string "ending_time"
    t.integer "key"
    t.bigint "show_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["show_id"], name: "index_events_on_show_id"
  end

  create_table "imported_files", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "file_name"
  end

  create_table "pricings", force: :cascade do |t|
    t.float "amount"
    t.string "product_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "purchasers", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "address"
    t.integer "zipcode"
    t.string "country"
    t.integer "age"
    t.string "gender"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shows", force: :cascade do |t|
    t.integer "key"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "imported_file_id"
    t.index ["imported_file_id"], name: "index_shows_on_imported_file_id"
  end

  add_foreign_key "bookings", "events"
  add_foreign_key "bookings", "imported_files"
  add_foreign_key "bookings", "pricings"
  add_foreign_key "bookings", "purchasers"
  add_foreign_key "bookings", "shows"
  add_foreign_key "events", "shows"
end
