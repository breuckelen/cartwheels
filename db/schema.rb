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

ActiveRecord::Schema.define(version: 20140509143436) do

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

  add_index "ads", ["ad_type_id"], name: "index_ads_on_ad_type_id"
  add_index "ads", ["cart_id"], name: "index_ads_on_cart_id"

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

  add_index "cart_suggestions", ["created_at", "borough"], name: "index_cart_suggestions_on_created_at_and_borough"
  add_index "cart_suggestions", ["created_at", "city"], name: "index_cart_suggestions_on_created_at_and_city"
  add_index "cart_suggestions", ["created_at", "name"], name: "index_cart_suggestions_on_created_at_and_name"
  add_index "cart_suggestions", ["created_at", "permit_number"], name: "index_cart_suggestions_on_created_at_and_permit_number"
  add_index "cart_suggestions", ["created_at", "zip_code"], name: "index_cart_suggestions_on_created_at_and_zip_code"
  add_index "cart_suggestions", ["permit_number"], name: "index_cart_suggestions_on_permit_number"

  create_table "cart_suggestions_users", force: true do |t|
    t.integer "cart_suggestion_id"
    t.integer "user_id"
  end

  add_index "cart_suggestions_users", ["cart_suggestion_id"], name: "index_cart_suggestions_users_on_cart_suggestion_id"
  add_index "cart_suggestions_users", ["user_id"], name: "index_cart_suggestions_users_on_user_id"

  create_table "cart_tag_relations", force: true do |t|
    t.integer  "cart_id"
    t.string   "cart_type"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cart_tag_relations", ["cart_id", "cart_type"], name: "index_cart_tag_relations_on_cart_id_and_cart_type"
  add_index "cart_tag_relations", ["tag_id"], name: "index_cart_tag_relations_on_tag_id"

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

  add_index "carts", ["created_at", "borough"], name: "index_carts_on_created_at_and_borough"
  add_index "carts", ["created_at", "city"], name: "index_carts_on_created_at_and_city"
  add_index "carts", ["created_at", "name"], name: "index_carts_on_created_at_and_name"
  add_index "carts", ["created_at", "permit_number"], name: "index_carts_on_created_at_and_permit_number"
  add_index "carts", ["created_at", "zip_code"], name: "index_carts_on_created_at_and_zip_code"
  add_index "carts", ["permit_number"], name: "index_carts_on_permit_number"

  create_table "carts_owners", force: true do |t|
    t.integer "cart_id"
    t.integer "owner_id"
  end

  add_index "carts_owners", ["cart_id"], name: "index_carts_owners_on_cart_id"
  add_index "carts_owners", ["owner_id"], name: "index_carts_owners_on_owner_id"

  create_table "clickthroughs", force: true do |t|
    t.integer  "count",      default: 0
    t.integer  "user_id"
    t.integer  "cart_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "clickthroughs", ["cart_id"], name: "index_clickthroughs_on_cart_id"
  add_index "clickthroughs", ["user_id"], name: "index_clickthroughs_on_user_id"

  create_table "menu_items", force: true do |t|
    t.text     "description"
    t.string   "image_url"
    t.float    "price"
    t.integer  "menu_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "menu_items", ["menu_id"], name: "index_menu_items_on_menu_id"

  create_table "menu_suggestions", force: true do |t|
    t.text     "description"
    t.string   "image_url"
    t.float    "price"
    t.integer  "menu_id"
    t.boolean  "approved",    default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "menu_suggestions", ["menu_id"], name: "index_menu_suggestions_on_menu_id"

  create_table "menu_suggestions_users", force: true do |t|
    t.integer "menu_suggestion_id"
    t.integer "user_id"
  end

  add_index "menu_suggestions_users", ["menu_suggestion_id"], name: "index_menu_suggestions_users_on_menu_suggestion_id"
  add_index "menu_suggestions_users", ["user_id"], name: "index_menu_suggestions_users_on_user_id"

  create_table "menus", force: true do |t|
    t.integer  "cart_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "menus", ["cart_id"], name: "index_menus_on_cart_id"

  create_table "owners", force: true do |t|
    t.string   "email_encrypted"
    t.string   "password_encrypted"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos", force: true do |t|
    t.string   "image_url"
    t.integer  "target_id"
    t.string   "target_type"
    t.integer  "author_id"
    t.integer  "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "photos", ["author_id", "author_type"], name: "index_photos_on_author_id_and_author_type"
  add_index "photos", ["target_id", "target_type"], name: "index_photos_on_target_id_and_target_type"

  create_table "reviews", force: true do |t|
    t.text     "text"
    t.integer  "rating"
    t.integer  "cart_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reviews", ["cart_id"], name: "index_reviews_on_cart_id"
  add_index "reviews", ["user_id"], name: "index_reviews_on_user_id"

  create_table "search_histories", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "search_histories", ["user_id"], name: "index_search_histories_on_user_id"

  create_table "search_lines", force: true do |t|
    t.integer  "search_history_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "search_lines", ["search_history_id"], name: "index_search_lines_on_search_history_id"

  create_table "search_lines_tokens", force: true do |t|
    t.integer "search_line_id"
    t.integer "search_token_id"
  end

  create_table "search_tokens", force: true do |t|
    t.string  "term"
    t.integer "count", default: 0
  end

  add_index "search_tokens", ["term"], name: "index_search_tokens_on_term"

  create_table "tags", force: true do |t|
    t.string   "text"
    t.integer  "count",      default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tags", ["text"], name: "index_tags_on_text"

  create_table "user_cart_relations", force: true do |t|
    t.integer "relation_type"
    t.integer "user_id"
    t.integer "cart_id"
  end

  add_index "user_cart_relations", ["cart_id"], name: "index_user_cart_relations_on_cart_id"
  add_index "user_cart_relations", ["user_id"], name: "index_user_cart_relations_on_user_id"

  create_table "users", force: true do |t|
    t.string   "email_encrypted"
    t.string   "username"
    t.string   "password_encrypted"
    t.integer  "zip_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["created_at", "username"], name: "index_users_on_created_at_and_username"
  add_index "users", ["created_at", "zip_code"], name: "index_users_on_created_at_and_zip_code"

end
