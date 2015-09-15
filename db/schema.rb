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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20150915113910) do

  create_table "games", :force => true do |t|
    t.string   "name"
    t.string   "company"
    t.text     "description"
    t.date     "released_at"
    t.integer  "grade"
    t.string   "platform"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "cover"
  end

  create_table "games_tournaments", :id => false, :force => true do |t|
    t.integer "game_id"
    t.integer "tournament_id"
  end

  create_table "matches", :force => true do |t|
    t.integer  "player_1_id"
    t.integer  "player_2_id"
    t.integer  "player_1_score"
    t.integer  "player_2_score"
    t.integer  "player_1_points"
    t.integer  "player_2_points"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "game_id"
    t.integer  "tournament_id"
  end

  create_table "profiles", :force => true do |t|
    t.integer  "user_id"
    t.string   "country"
    t.integer  "score"
    t.integer  "victories"
    t.integer  "defeats"
    t.float    "ratio"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "avatar"
    t.date     "date_of_birth"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "tournaments", :force => true do |t|
    t.string   "place"
    t.date     "date"
    t.integer  "max_player"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "name"
    t.text     "description"
  end

  create_table "tournaments_users", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "tournament_id"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "hashed_password"
    t.string   "role"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "provider"
    t.string   "uid"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
  end

end
