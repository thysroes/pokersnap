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

ActiveRecord::Schema[8.0].define(version: 2025_08_11_200702) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "action_records", force: :cascade do |t|
    t.bigint "player_id", null: false
    t.bigint "game_room_id", null: false
    t.string "action_type"
    t.integer "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_room_id"], name: "index_action_records_on_game_room_id"
    t.index ["player_id"], name: "index_action_records_on_player_id"
  end

  create_table "game_rooms", force: :cascade do |t|
    t.string "room_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0, null: false
    t.jsonb "community_cards", default: []
    t.integer "pot_amount", default: 0
    t.index ["status"], name: "index_game_rooms_on_status"
  end

  create_table "players", force: :cascade do |t|
    t.string "nickname"
    t.integer "seat_number"
    t.integer "stack_amount"
    t.jsonb "hole_cards"
    t.bigint "game_room_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_room_id"], name: "index_players_on_game_room_id"
  end

  add_foreign_key "action_records", "game_rooms"
  add_foreign_key "action_records", "players"
  add_foreign_key "players", "game_rooms"
end
