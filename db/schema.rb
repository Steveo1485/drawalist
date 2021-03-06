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

ActiveRecord::Schema.define(version: 20151126063257) do

  create_table "groups", force: :cascade do |t|
    t.integer  "user_id",    limit: 4,   null: false
    t.string   "name",       limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "token",      limit: 255
  end

  add_index "groups", ["token"], name: "index_groups_on_token", unique: true, using: :btree
  add_index "groups", ["user_id"], name: "index_groups_on_user_id", using: :btree

  create_table "invitations", force: :cascade do |t|
    t.integer  "group_id",   limit: 4,   null: false
    t.string   "email",      limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "invitations", ["email"], name: "index_invitations_on_email", using: :btree
  add_index "invitations", ["group_id"], name: "index_invitations_on_group_id", using: :btree
  add_index "invitations", ["group_id"], name: "index_invitations_on_group_id_and_is_member", using: :btree

  create_table "list_items", force: :cascade do |t|
    t.integer  "list_id",    limit: 4,   null: false
    t.string   "name",       limit: 255, null: false
    t.string   "url",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "list_items", ["list_id"], name: "index_list_items_on_list_id", using: :btree

  create_table "lists", force: :cascade do |t|
    t.integer  "user_id",        limit: 4, null: false
    t.integer  "group_id",       limit: 4, null: false
    t.integer  "paired_user_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "lists", ["group_id"], name: "index_lists_on_group_id", using: :btree
  add_index "lists", ["paired_user_id", "group_id"], name: "index_lists_on_paired_user_id_and_group_id", using: :btree
  add_index "lists", ["paired_user_id"], name: "index_lists_on_paired_user_id", using: :btree
  add_index "lists", ["user_id", "group_id"], name: "index_lists_on_user_id_and_group_id", using: :btree
  add_index "lists", ["user_id"], name: "index_lists_on_user_id", using: :btree

  create_table "memberships", force: :cascade do |t|
    t.integer  "user_id",    limit: 4, null: false
    t.integer  "group_id",   limit: 4, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "memberships", ["group_id"], name: "index_memberships_on_group_id", using: :btree
  add_index "memberships", ["user_id", "group_id"], name: "index_memberships_on_user_id_and_group_id", using: :btree
  add_index "memberships", ["user_id"], name: "index_memberships_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "first_name",             limit: 255,              null: false
    t.string   "last_name",              limit: 255,              null: false
    t.string   "provider",               limit: 255
    t.string   "uid",                    limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["provider"], name: "index_users_on_provider", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["uid"], name: "index_users_on_uid", using: :btree

end
