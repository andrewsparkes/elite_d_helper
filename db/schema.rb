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

ActiveRecord::Schema.define(version: 20150219204000) do

  create_table "allegiances", force: true do |t|
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

  create_table "governments", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "population_levels", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "station_commodities", force: true do |t|
    t.integer  "station_id"
    t.integer  "commodity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sell"
    t.integer  "buy"
    t.integer  "demand"
    t.string   "demand_level"
    t.integer  "supply"
    t.string   "supply_level"
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
    t.integer  "allegiance_id"
    t.integer  "population_level_id"
    t.integer  "government_id"
    t.boolean  "has_blackmarket"
    t.integer  "nav_ls"
    t.boolean  "is_economy_agricultural", default: false, null: false
    t.boolean  "is_economy_extraction",   default: false, null: false
    t.boolean  "is_economy_hi_tech",      default: false, null: false
    t.boolean  "is_economy_industrial",   default: false, null: false
    t.boolean  "is_economy_military",     default: false, null: false
    t.boolean  "is_economy_none",         default: false, null: false
    t.boolean  "is_economy_refinery",     default: false, null: false
    t.boolean  "is_economy_service",      default: false, null: false
    t.boolean  "is_economy_terraforming", default: false, null: false
    t.boolean  "is_economy_tourism",      default: false, null: false
  end

  create_table "systems", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "eds_id"
    t.float    "x"
    t.float    "y"
    t.float    "z"
    t.integer  "allegiance_id"
    t.integer  "government_id"
  end

end
