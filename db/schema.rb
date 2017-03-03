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

ActiveRecord::Schema.define(version: 20170303130718) do

  create_table "answers", force: :cascade do |t|
    t.text     "content",     limit: 65535
    t.integer  "user_id",     limit: 4
    t.integer  "question_id", limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "rank_value",  limit: 4
  end

  create_table "assignments", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "task_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

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

  create_table "categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
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
    t.text     "content",               limit: 65535
    t.integer  "user_id",               limit: 4
    t.string   "commentable_type",      limit: 255
    t.integer  "commentable_id",        limit: 4
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "document_file_name",    limit: 255
    t.string   "document_content_type", limit: 255
    t.integer  "document_file_size",    limit: 4
    t.datetime "document_updated_at"
    t.string   "avatar_file_name",      limit: 255
    t.string   "avatar_content_type",   limit: 255
    t.integer  "avatar_file_size",      limit: 4
    t.datetime "avatar_updated_at"
  end

  create_table "courses", force: :cascade do |t|
    t.string   "name",                limit: 255
    t.string   "course_type",         limit: 255
    t.string   "course_field",        limit: 255
    t.string   "course_grade",        limit: 255
    t.integer  "course_points",       limit: 4
    t.integer  "lecturer_id",         limit: 4
    t.text     "course_targets",      limit: 65535
    t.text     "course_results",      limit: 65535
    t.text     "course_covered",      limit: 65535
    t.string   "course_softwares",    limit: 255
    t.string   "problems_period",     limit: 255
    t.string   "garding_mechanism",   limit: 255
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.boolean  "delta",               limit: 1,     default: true, null: false
    t.string   "avatar_file_name",    limit: 255
    t.string   "avatar_content_type", limit: 255
    t.integer  "avatar_file_size",    limit: 4
    t.datetime "avatar_updated_at"
    t.integer  "user_id",             limit: 4
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

  create_table "goods", force: :cascade do |t|
    t.string   "name",                limit: 255
    t.text     "description",         limit: 65535
    t.string   "price",               limit: 255
    t.integer  "user_id",             limit: 4
    t.integer  "category_id",         limit: 4
    t.integer  "sub_category_id",     limit: 4
    t.date     "deadline"
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.string   "avatar_file_name",    limit: 255
    t.string   "avatar_content_type", limit: 255
    t.integer  "avatar_file_size",    limit: 4
    t.datetime "avatar_updated_at"
    t.boolean  "delta",               limit: 1,     default: true, null: false
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

  create_table "labs", force: :cascade do |t|
    t.string   "name",                limit: 255
    t.text     "about",               limit: 65535
    t.text     "missions",            limit: 65535
    t.string   "tel",                 limit: 255
    t.text     "address",             limit: 65535
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.boolean  "delta",               limit: 1,     default: true, null: false
    t.integer  "user_id",             limit: 4
    t.string   "avatar_file_name",    limit: 255
    t.string   "avatar_content_type", limit: 255
    t.integer  "avatar_file_size",    limit: 4
    t.datetime "avatar_updated_at"
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

  create_table "partnerships", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "project_id", limit: 4
    t.integer  "role",       limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "preports", force: :cascade do |t|
    t.integer  "user_id",               limit: 4
    t.integer  "task_id",               limit: 4
    t.text     "detail",                limit: 65535
    t.string   "status",                limit: 255
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "document_file_name",    limit: 255
    t.string   "document_content_type", limit: 255
    t.integer  "document_file_size",    limit: 4
    t.datetime "document_updated_at"
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

  create_table "projects", force: :cascade do |t|
    t.string   "name",                limit: 255
    t.text     "aims",                limit: 65535
    t.integer  "owner",               limit: 4
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "project_type",        limit: 255
    t.string   "location",            limit: 255
    t.text     "definition",          limit: 65535
    t.text     "novelties",           limit: 65535
    t.text     "methods",             limit: 65535
    t.text     "standards",           limit: 65535
    t.text     "outputs",             limit: 65535
    t.string   "avatar_file_name",    limit: 255
    t.string   "avatar_content_type", limit: 255
    t.integer  "avatar_file_size",    limit: 4
    t.datetime "avatar_updated_at"
    t.integer  "user_id",             limit: 4
  end

  create_table "qitems", force: :cascade do |t|
    t.string   "content",         limit: 255
    t.integer  "questionaire_id", limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "questionaires", force: :cascade do |t|
    t.text     "question",   limit: 65535
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "questions", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.text     "content",    limit: 65535
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "rank_value", limit: 4
  end

  create_table "researches", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "pub_year",    limit: 255
    t.string   "pub_type",    limit: 255
    t.string   "pub_name",    limit: 255
    t.string   "pub_authors", limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "user_id",     limit: 4
    t.text     "abstract",    limit: 65535
  end

  create_table "seekings", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "blog_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "role",       limit: 4
  end

  create_table "sub_categories", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.integer  "category_id", limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "taggable_id",   limit: 4
    t.string   "taggable_type", limit: 255
    t.integer  "tag_id",        limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "user_id",    limit: 4
    t.boolean  "delta",      limit: 1,   default: true, null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "description", limit: 65535
    t.date     "start_date"
    t.date     "due_date"
    t.integer  "status",      limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "project_id",  limit: 4
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

  create_table "votes", force: :cascade do |t|
    t.integer  "user_id",       limit: 4
    t.string   "voteable_type", limit: 255
    t.integer  "voteable_id",   limit: 4
    t.integer  "amount",        limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

end
