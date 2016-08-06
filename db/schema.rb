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

ActiveRecord::Schema.define(version: 20160806084045) do

  create_table "carrier_details", force: :cascade do |t|
    t.string   "carrier_id", limit: 255
    t.string   "email_id",   limit: 255
    t.string   "first_name", limit: 255
    t.string   "last_name",  limit: 255
    t.string   "img_link",   limit: 255
    t.string   "phone",      limit: 255
    t.string   "status",     limit: 255
    t.date     "deleted_at"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "sender_details", force: :cascade do |t|
    t.string   "sender_id",  limit: 255
    t.string   "email_id",   limit: 255
    t.string   "first_name", limit: 255
    t.string   "last_name",  limit: 255
    t.string   "img_link",   limit: 255
    t.string   "phone",      limit: 255
    t.string   "status",     limit: 255
    t.date     "deleted_at"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

end
