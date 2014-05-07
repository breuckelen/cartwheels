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

ActiveRecord::Schema.define(version: 20140507045300) do

  create_table "ad_types", force: true do |t|
    t.string  "title"
    t.text    "description"
    t.integer "duration"
    t.float   "price"
  end

  create_table "ads", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "cart_id"
    t.integer  "ad_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cart_suggestions", force: true do |t|
    t.string   "name"
    t.string   "city"
    t.string   "borough"
    t.integer  "permit_number"
    t.integer  "zip_code"
    t.float    "lat"
    t.float    "lon"
    t.boolean  "approved",      default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cart_suggestions_users", force: true do |t|
    t.integer "cart_suggestion_id"
    t.integer "user_id"
  end

  create_table "carts", force: true do |t|
    t.string   "name"
    t.string   "city"
    t.string   "borough"
    t.integer  "owner_secret"
    t.integer  "permit_number"
    t.integer  "zip_code"
    t.integer  "lat"
    t.integer  "lon"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "carts_owners", force: true do |t|
    t.integer "cart_id"
    t.integer "owner_id"
  end

  create_table "menu_items", force: true do |t|
    t.text     "description"
    t.string   "image_url"
    t.float    "price"
    t.integer  "menu_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "menu_suggestions", force: true do |t|
    t.text     "description"
    t.string   "image_url"
    t.float    "price"
    t.integer  "menu_id"
    t.boolean  "approved",    default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "menu_suggestions_users", force: true do |t|
    t.integer "menu_suggestion_id"
    t.integer "user_id"
  end

  create_table "menus", force: true do |t|
    t.integer  "cart_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "owners", force: true do |t|
    t.string   "email"
    t.string   "password"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reviews", force: true do |t|
    t.text     "text"
    t.integer  "rating"
    t.integer  "cart_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "search_histories", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "search_lines", force: true do |t|
    t.integer  "search_history_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "search_tokens", force: true do |t|
    t.string  "term"
    t.integer "count", default: 0
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "username"
    t.string   "password"
    t.integer  "zip_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
