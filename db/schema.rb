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

ActiveRecord::Schema.define(version: 20140106171018) do

  create_table "project_mappings", force: true do |t|
    t.integer  "user_setting_id",     null: false
    t.string   "external_project_id", null: false
    t.string   "harvest_project_id",  null: false
    t.string   "harvest_task_id",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_settings", force: true do |t|
    t.integer  "user_id",                                                 null: false
    t.string   "encrypted_tracker_full_name",                             null: false
    t.string   "encrypted_tracker_api_token",                             null: false
    t.string   "encrypted_harvest_organization",                          null: false
    t.string   "encrypted_harvest_username",                              null: false
    t.string   "encrypted_harvest_password",                              null: false
    t.string   "output",                         default: "multi_line",   null: false
    t.string   "style",                          default: "story_number", null: false
    t.boolean  "comma_deliminated",              default: false,          null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
