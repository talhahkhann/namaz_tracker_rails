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

ActiveRecord::Schema[8.1].define(version: 2026_06_21_095030) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "masjids", force: :cascade do |t|
    t.string "address"
    t.datetime "created_at", null: false
    t.integer "created_by"
    t.integer "imam_id"
    t.string "name"
    t.datetime "updated_at", null: false
    t.integer "updated_by"
    t.index ["imam_id"], name: "index_masjids_on_imam_id"
  end

  create_table "memberships", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "masjid_id", null: false
    t.string "role"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["masjid_id"], name: "index_memberships_on_masjid_id"
    t.index ["user_id"], name: "index_memberships_on_user_id"
  end

  create_table "namaz_schedules", force: :cascade do |t|
    t.time "asr"
    t.datetime "created_at", null: false
    t.time "dhuhr"
    t.time "fajr"
    t.time "isha"
    t.time "maghrib"
    t.bigint "masjid_id", null: false
    t.datetime "updated_at", null: false
    t.index ["masjid_id"], name: "index_namaz_schedules_on_masjid_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.string "name"
    t.string "password_digest"
    t.integer "role", default: 0
    t.datetime "updated_at", null: false
  end

  add_foreign_key "masjids", "users", column: "imam_id"
  add_foreign_key "memberships", "masjids"
  add_foreign_key "memberships", "users"
  add_foreign_key "namaz_schedules", "masjids"
end
