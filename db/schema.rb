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

ActiveRecord::Schema.define(version: 20150210133503) do

  create_table "buildings", force: :cascade do |t|
    t.string   "city",                 limit: 255
    t.string   "street",               limit: 255
    t.string   "number",               limit: 255
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "num_of_facilities",    limit: 4
    t.integer  "full_building_square", limit: 4
  end

  create_table "user_buildings", force: :cascade do |t|
    t.integer  "user_id",       limit: 4
    t.integer  "building_id",   limit: 4
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.integer  "apartment",     limit: 4
    t.integer  "share",         limit: 4
    t.text     "address",       limit: 65535
    t.string   "series",        limit: 255
    t.string   "number",        limit: 255
    t.date     "date_of_issue"
    t.string   "certificate",   limit: 255
    t.boolean  "is_submitted",  limit: 1,     default: false
  end

  add_index "user_buildings", ["building_id"], name: "index_user_buildings_on_building_id", using: :btree
  add_index "user_buildings", ["user_id"], name: "index_user_buildings_on_user_id", using: :btree

  create_table "user_votings", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "voting_id",  limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "user_votings", ["user_id"], name: "index_user_votings_on_user_id", using: :btree
  add_index "user_votings", ["voting_id"], name: "index_user_votings_on_voting_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                           limit: 255,               null: false
    t.string   "crypted_password",                limit: 255
    t.string   "salt",                            limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_me_token",               limit: 255
    t.datetime "remember_me_token_expires_at"
    t.string   "reset_password_token",            limit: 255
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.string   "activation_state",                limit: 255
    t.string   "activation_token",                limit: 255
    t.datetime "activation_token_expires_at"
    t.integer  "failed_logins_count",             limit: 4,     default: 0
    t.datetime "lock_expires_at"
    t.string   "unlock_token",                    limit: 255
    t.datetime "last_login_at"
    t.datetime "last_logout_at"
    t.datetime "last_activity_at"
    t.string   "last_login_from_ip_address",      limit: 255
    t.integer  "status",                          limit: 4
    t.string   "series",                          limit: 255
    t.string   "number",                          limit: 255
    t.date     "date_of_issue"
    t.string   "country_of_issue",                limit: 255
    t.text     "issuing_authority",               limit: 65535
    t.integer  "type_of_organization",            limit: 4
    t.string   "org_full_name",                   limit: 255
    t.string   "org_ogrn",                        limit: 255
    t.string   "org_inn",                         limit: 255
    t.integer  "document_type",                   limit: 4
  end

  add_index "users", ["activation_token"], name: "index_users_on_activation_token", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["last_logout_at", "last_activity_at"], name: "index_users_on_last_logout_at_and_last_activity_at", using: :btree
  add_index "users", ["remember_me_token"], name: "index_users_on_remember_me_token", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", using: :btree

  create_table "voting_questions", force: :cascade do |t|
    t.integer  "voting_id",   limit: 4
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "voting_questions", ["voting_id"], name: "index_voting_questions_on_voting_id", using: :btree

  create_table "votings", force: :cascade do |t|
    t.integer  "user_id",      limit: 4
    t.date     "start_at"
    t.datetime "end_at"
    t.text     "description",  limit: 65535
    t.string   "title",        limit: 255
    t.string   "attachment",   limit: 255
    t.boolean  "notify_all",   limit: 1,     default: false
    t.boolean  "is_closed",    limit: 1,     default: false
    t.boolean  "is_published", limit: 1,     default: false
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.integer  "building_id",  limit: 4
  end

  add_index "votings", ["building_id"], name: "index_votings_on_building_id", using: :btree
  add_index "votings", ["user_id"], name: "index_votings_on_user_id", using: :btree

  add_foreign_key "user_buildings", "buildings"
  add_foreign_key "user_buildings", "users"
  add_foreign_key "user_votings", "users"
  add_foreign_key "user_votings", "votings"
  add_foreign_key "voting_questions", "votings"
  add_foreign_key "votings", "buildings"
  add_foreign_key "votings", "users"
end
