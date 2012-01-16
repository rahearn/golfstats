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

ActiveRecord::Schema.define(:version => 20120116221353) do

  create_table "course_notes", :force => true do |t|
    t.text     "note"
    t.integer  "user_id"
    t.integer  "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "course_notes", ["course_id"], :name => "index_course_notes_on_course_id"
  add_index "course_notes", ["user_id"], :name => "index_course_notes_on_user_id"

  create_table "courses", :force => true do |t|
    t.string   "name",       :null => false
    t.string   "location",   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "courses", ["location"], :name => "index_courses_on_location"
  add_index "courses", ["name", "location"], :name => "index_courses_on_name_and_location", :unique => true
  add_index "courses", ["name"], :name => "index_courses_on_name"

  create_table "rounds", :force => true do |t|
    t.date     "date",                                       :null => false
    t.integer  "score",                                      :null => false
    t.float    "differential"
    t.integer  "user_id",                                    :null => false
    t.integer  "course_id",                                  :null => false
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "scorecard_id"
    t.integer  "slope"
    t.decimal  "rating",       :precision => 4, :scale => 1
  end

  add_index "rounds", ["course_id"], :name => "index_rounds_on_course_id"
  add_index "rounds", ["user_id"], :name => "index_rounds_on_user_id"

  create_table "users", :force => true do |t|
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                                                  :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
    t.string   "name"
    t.string   "openid_uid",                                                                         :null => false
    t.string   "gender",              :limit => 6,                               :default => "male"
    t.decimal  "handicap",                         :precision => 3, :scale => 1
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["openid_uid"], :name => "index_users_on_openid_uid", :unique => true

end
