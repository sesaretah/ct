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

ActiveRecord::Schema.define(version: 20161230133328) do

  create_table "blogs", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.integer  "user_id",     limit: 4
    t.integer  "p_type",      limit: 4
    t.integer  "g_type",      limit: 4
    t.integer  "i_type",      limit: 4
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.text     "description", limit: 65535
    t.boolean  "delta",       limit: 1,     default: true, null: false
  end

  create_table "channels", force: :cascade do |t|
    t.string   "name",                limit: 255
    t.text     "description",         limit: 65535
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.string   "avatar_file_name",    limit: 255
    t.string   "avatar_content_type", limit: 255
    t.integer  "avatar_file_size",    limit: 4
    t.datetime "avatar_updated_at"
    t.integer  "user_id",             limit: 4
    t.boolean  "delta",               limit: 1,     default: true, null: false
    t.integer  "g_type",              limit: 4
    t.integer  "p_type",              limit: 4
    t.integer  "i_type",              limit: 4
  end

  create_table "comments", force: :cascade do |t|
    t.text     "content",          limit: 65535
    t.integer  "user_id",          limit: 4
    t.string   "commentable_type", limit: 255
    t.integer  "commentable_id",   limit: 4
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "educations", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "grade",      limit: 255
    t.string   "city",       limit: 255
    t.string   "country",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "user_id",    limit: 4
    t.string   "field",      limit: 255
    t.integer  "start_year", limit: 4
    t.integer  "end_year",   limit: 4
    t.float    "gpa",        limit: 24
    t.string   "title",      limit: 255
    t.string   "thesis_gpa", limit: 255
  end

  create_table "events", force: :cascade do |t|
    t.string   "name",                limit: 255
    t.text     "description",         limit: 65535
    t.date     "event_date"
    t.time     "start_time"
    t.time     "end_time"
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.string   "avatar_file_name",    limit: 255
    t.string   "avatar_content_type", limit: 255
    t.integer  "avatar_file_size",    limit: 4
    t.datetime "avatar_updated_at"
    t.integer  "user_id",             limit: 4
    t.integer  "p_type",              limit: 4
    t.string   "location",            limit: 255
    t.integer  "g_type",              limit: 4
    t.boolean  "delta",               limit: 1,     default: true, null: false
    t.integer  "i_type",              limit: 4
  end

  create_table "groupings", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "group_id",   limit: 4
    t.integer  "adder_id",   limit: 4
    t.integer  "role",       limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "groups", force: :cascade do |t|
    t.string   "name",                limit: 255
    t.text     "description",         limit: 65535
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.string   "avatar_file_name",    limit: 255
    t.string   "avatar_content_type", limit: 255
    t.integer  "avatar_file_size",    limit: 4
    t.datetime "avatar_updated_at"
    t.integer  "user_id",             limit: 4
    t.integer  "p_type",              limit: 4
    t.boolean  "delta",               limit: 1,     default: true, null: false
    t.integer  "i_type",              limit: 4
  end

  create_table "honors", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.string   "year",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "user_id",    limit: 4
  end

  create_table "involvements", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "channel_id", limit: 4
    t.integer  "adder_id",   limit: 4
    t.integer  "role",       limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "sender_id",    limit: 4
    t.integer  "recipient_id", limit: 4
    t.text     "content",      limit: 65535
    t.integer  "status",       limit: 4
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "title",        limit: 255
  end

  create_table "notes", force: :cascade do |t|
    t.text     "content",    limit: 65535
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "title",      limit: 255
    t.integer  "blog_id",    limit: 4
  end

  create_table "participations", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "event_id",   limit: 4
    t.integer  "adder_id",   limit: 4
    t.integer  "role",       limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.string   "name",                limit: 255
    t.string   "surename",            limit: 255
    t.date     "birthdate"
    t.string   "sex",                 limit: 255
    t.integer  "user_id",             limit: 4
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.string   "avatar_file_name",    limit: 255
    t.string   "avatar_content_type", limit: 255
    t.integer  "avatar_file_size",    limit: 4
    t.datetime "avatar_updated_at"
    t.string   "fathername",          limit: 255
    t.string   "ssn",                 limit: 255
    t.string   "phonenumber",         limit: 255
    t.string   "mobilenumber",        limit: 255
    t.boolean  "delta",               limit: 1,   default: true, null: false
  end

  create_table "researches", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "pub_year",    limit: 255
    t.string   "pub_type",    limit: 255
    t.string   "pub_name",    limit: 255
    t.string   "pub_authors", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "user_id",     limit: 4
  end

  create_table "seekings", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "blog_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "role",       limit: 4
  end

  create_table "tags", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "user_id",    limit: 4
  end

  create_table "uploads", force: :cascade do |t|
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
  end

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
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
