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

ActiveRecord::Schema.define(version: 20130819235235) do

  create_table "players", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "position_id"
    t.string   "team"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "players", ["position_id"], name: "index_players_on_position_id"

  create_table "positions", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "abbrev"
  end

  create_table "rankings", force: true do |t|
    t.integer  "source_id"
    t.integer  "player_id"
    t.integer  "overall_rank"
    t.integer  "pos_rank"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rankings", ["player_id"], name: "index_rankings_on_player_id"
  add_index "rankings", ["source_id"], name: "index_rankings_on_source_id"

  create_table "sources", force: true do |t|
    t.string   "name"
    t.string   "url"
    t.decimal  "weight"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "site"
  end

end
