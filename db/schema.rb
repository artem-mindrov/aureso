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

ActiveRecord::Schema.define(version: 20160402181358) do

  create_table "auth_tokens", force: true do |t|
    t.string   "body",         null: false
    t.integer  "user_id"
    t.datetime "last_used_at"
    t.string   "ip",           null: false
    t.string   "user_agent",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "auth_tokens", ["user_id"], name: "index_auth_tokens_on_user_id"

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"

  create_table "model_types", force: true do |t|
    t.integer  "model_id",        null: false
    t.string   "name",            null: false
    t.string   "model_type_code"
    t.string   "slug"
    t.decimal  "base_price",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "model_types", ["model_id"], name: "index_model_types_on_model_id"
  add_index "model_types", ["slug"], name: "index_model_types_on_slug", unique: true

  create_table "models", force: true do |t|
    t.integer  "organization_id", null: false
    t.string   "name",            null: false
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "models", ["name"], name: "index_models_on_name", unique: true
  add_index "models", ["organization_id"], name: "index_models_on_organization_id"
  add_index "models", ["slug"], name: "index_models_on_slug", unique: true

  create_table "organizations", force: true do |t|
    t.string   "name",                       null: false
    t.string   "public_name",                null: false
    t.integer  "type",           default: 0, null: false
    t.integer  "pricing_policy", default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",           null: false
    t.string   "password_digest", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
