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

ActiveRecord::Schema.define(version: 20180219020416) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "artists", force: :cascade do |t|
    t.string   "name"
    t.integer  "location_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["location_id"], name: "index_artists_on_location_id", using: :btree
  end

  create_table "bookings", force: :cascade do |t|
    t.string   "location"
    t.string   "artist"
    t.string   "service"
    t.time     "time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "statuses", force: :cascade do |t|
    t.string   "status"
    t.string   "sender"
    t.string   "language"
    t.integer  "count"
    t.string   "location"
    t.string   "intent"
    t.hstore   "log",        default: {"rudsak"=>"0", "academy"=>"0", "mileEnd"=>"0", "quartier"=>"0", "villeMarie"=>"0", "vieuxMontreal"=>"0"}, null: false
    t.datetime "created_at",                                                                                                                     null: false
    t.datetime "updated_at",                                                                                                                     null: false
  end

  add_foreign_key "artists", "locations"
end
