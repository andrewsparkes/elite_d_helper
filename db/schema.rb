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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20141219131838) do

  create_table "alliances", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "commodities", force: true do |t|
    t.integer  "commodity_type_id"
    t.string   "name"
    t.integer  "galactic_average_price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "commodity_types", force: true do |t|
    t.string   "name"
    t.integer  "order_num"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "station_commodities", force: true do |t|
    t.integer  "station_id"
    t.integer  "commodity_id"
    t.string   "demanded_or_supplied"
    t.string   "demand_or_supply_level"
    t.integer  "buy_or_sell_price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "station_types", force: true do |t|
    t.string   "name"
    t.boolean  "has_small_dock"
    t.boolean  "has_medium_dock"
    t.boolean  "has_large_dock"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stations", force: true do |t|
    t.integer  "system_id"
    t.integer  "station_type_id"
    t.string   "name"
    t.boolean  "has_commodities"
    t.boolean  "has_refuel"
    t.boolean  "has_repair"
    t.boolean  "has_re_arm"
    t.boolean  "has_outfitting"
    t.boolean  "has_shipyard"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "systems", force: true do |t|
    t.string   "name"
    t.integer  "alliance_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
