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

ActiveRecord::Schema.define(version: 20140731140456) do

  create_table "attendances", force: true do |t|
    t.integer  "session_id"
    t.integer  "student_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "searches", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "kind"
  end

  create_table "students", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role"
    t.string   "first_name"
    t.string   "nick_name"
    t.string   "goes_by"
    t.string   "last_name"
    t.string   "official_full_name"
    t.string   "net_id"
    t.string   "cell"
    t.string   "yale_email"
    t.string   "yale_email_alias"
    t.string   "non_yale_email"
    t.string   "queue"
    t.string   "old_queue"
    t.string   "college"
    t.integer  "class_year"
    t.string   "birthday"
    t.text     "other"
  end

end
