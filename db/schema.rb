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

ActiveRecord::Schema.define(version: 20170726090738) do

  create_table "bank_details", force: :cascade do |t|
    t.string   "uid",        limit: 255
    t.string   "account_no", limit: 255
    t.string   "ifsc",       limit: 255
    t.string   "bank_name",  limit: 255
    t.string   "ref_1",      limit: 255
    t.string   "ref_2",      limit: 255
    t.string   "ref_3",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "carrier_details", force: :cascade do |t|
    t.string   "carrier_id", limit: 255
    t.string   "email_id",   limit: 255
    t.string   "first_name", limit: 255
    t.string   "last_name",  limit: 255
    t.string   "img_link",   limit: 1024
    t.string   "phone",      limit: 255
    t.string   "status",     limit: 255
    t.date     "deleted_at"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "carrier_schedule_details", force: :cascade do |t|
    t.string   "schedule_id",    limit: 255
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "mode",           limit: 255
    t.string   "capacity",       limit: 255
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "ready_to_carry", limit: 255
  end

  create_table "carrier_schedules", force: :cascade do |t|
    t.string   "schedule_id",   limit: 255
    t.string   "carrier_id",    limit: 255
    t.string   "from_loc",      limit: 255
    t.string   "to_loc",        limit: 255
    t.decimal  "from_geo_lat",               precision: 10, scale: 6
    t.decimal  "to_geo_lat",                 precision: 10, scale: 6
    t.string   "status",        limit: 255
    t.string   "comments",      limit: 255
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
    t.string   "stop_overs",    limit: 3072
    t.string   "from_geo_long", limit: 255
    t.string   "to_geo_long",   limit: 255
  end

  create_table "ccnotifications", force: :cascade do |t|
    t.string   "user_id",           limit: 255
    t.string   "order_schedule_id", limit: 255
    t.string   "notif_type",        limit: 255
    t.string   "message",           limit: 255
    t.string   "ref_1",             limit: 255
    t.string   "ref_2",             limit: 255
    t.string   "ref_3",             limit: 255
    t.string   "ref_4",             limit: 255
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "complete_orders", force: :cascade do |t|
    t.string   "order_id",   limit: 255
    t.string   "otp",        limit: 255
    t.string   "status",     limit: 255
    t.string   "ref_1",      limit: 255
    t.string   "ref_2",      limit: 255
    t.string   "ref_3",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "coupons", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.decimal  "discount",               precision: 10, scale: 6
    t.string   "status",     limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  create_table "customer_supports", force: :cascade do |t|
    t.string   "contact_no", limit: 255
    t.string   "name",       limit: 255
    t.string   "issue",      limit: 255
    t.string   "comments",   limit: 255
    t.string   "ref_1",      limit: 255
    t.string   "ref_2",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   limit: 4,     default: 0, null: false
    t.integer  "attempts",   limit: 4,     default: 0, null: false
    t.text     "handler",    limit: 65535,             null: false
    t.text     "last_error", limit: 65535
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 255
    t.string   "queue",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "notifications", force: :cascade do |t|
    t.string   "user_id",           limit: 255
    t.string   "order_schedule_id", limit: 255
    t.string   "type",              limit: 255
    t.string   "message",           limit: 255
    t.string   "ref_1",             limit: 255
    t.string   "ref_2",             limit: 255
    t.string   "ref_3",             limit: 255
    t.string   "ref_4",             limit: 255
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "order_transaction_histories", force: :cascade do |t|
    t.string   "transaction_id",         limit: 255
    t.string   "carrier_id",             limit: 255
    t.string   "order_id",               limit: 255
    t.decimal  "open_amount",                        precision: 18, scale: 3, default: 0.0
    t.decimal  "applied_amount",                     precision: 18, scale: 3, default: 0.0
    t.decimal  "pending_applied_amount",             precision: 18, scale: 3, default: 0.0
    t.string   "status",                 limit: 255
    t.datetime "created_at",                                                                null: false
    t.datetime "updated_at",                                                                null: false
  end

  create_table "otps", force: :cascade do |t|
    t.string   "phone",      limit: 255
    t.string   "otp",        limit: 255
    t.string   "status",     limit: 255
    t.datetime "expiry"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "pickup_order_mappings", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.string   "order_id",       limit: 255
    t.string   "sender_id",      limit: 255
    t.string   "phone",          limit: 255
    t.string   "address_line_1", limit: 255
    t.string   "address_line_2", limit: 255
    t.string   "state",          limit: 255
    t.string   "landmark",       limit: 255
    t.string   "pin",            limit: 255
    t.string   "status",         limit: 255
    t.boolean  "auto_save"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "ratings", force: :cascade do |t|
    t.string   "user",       limit: 255
    t.string   "rated_by",   limit: 255
    t.string   "comments",   limit: 255
    t.integer  "rating",     limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "receiver_order_mappings", force: :cascade do |t|
    t.string   "reciever_id",    limit: 255
    t.string   "order_id",       limit: 255
    t.string   "sender_id",      limit: 255
    t.string   "name",           limit: 255
    t.string   "phone_1",        limit: 255
    t.string   "phone_2",        limit: 255
    t.string   "address_line_1", limit: 255
    t.string   "address_line_2", limit: 255
    t.string   "state",          limit: 255
    t.string   "landmark",       limit: 255
    t.string   "pin",            limit: 255
    t.string   "status",         limit: 255
    t.boolean  "auto_save"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "sender_details", force: :cascade do |t|
    t.string   "sender_id",           limit: 255
    t.string   "email_id",            limit: 255
    t.string   "first_name",          limit: 255
    t.string   "last_name",           limit: 255
    t.string   "img_link",            limit: 1024
    t.string   "phone",               limit: 255
    t.string   "status",              limit: 255
    t.date     "deleted_at"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "avatar_content_type", limit: 255
    t.string   "avatar_file_name",    limit: 255
    t.integer  "avatar_file_size",    limit: 4
    t.datetime "avatar_updated_at"
  end

  create_table "sender_order_items", force: :cascade do |t|
    t.string   "order_id",        limit: 255
    t.string   "item_attributes", limit: 2048
    t.decimal  "unit_price",                   precision: 18, scale: 3, default: 0.0
    t.integer  "quantity",        limit: 4
    t.decimal  "total_amount",                 precision: 18, scale: 3, default: 0.0
    t.decimal  "tax",                          precision: 10, scale: 6
    t.string   "item_type",       limit: 255
    t.string   "item_subtype",    limit: 255
    t.string   "img",             limit: 1024
    t.datetime "created_at",                                                          null: false
    t.datetime "updated_at",                                                          null: false
    t.datetime "start_time"
    t.datetime "end_time"
    t.decimal  "grand_total",                  precision: 18, scale: 3
  end

  create_table "sender_orders", force: :cascade do |t|
    t.string   "order_id",      limit: 255
    t.string   "sender_id",     limit: 255
    t.string   "from_loc",      limit: 255
    t.string   "to_loc",        limit: 255
    t.decimal  "total_amount",              precision: 18, scale: 3
    t.decimal  "from_geo_lat",              precision: 10, scale: 6
    t.string   "from_geo_long", limit: 255
    t.string   "to_geo_long",   limit: 255
    t.decimal  "to_geo_lat",                precision: 10, scale: 6
    t.string   "status",        limit: 255
    t.string   "comments",      limit: 255
    t.string   "type",          limit: 255
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.string   "coupon",        limit: 255
    t.boolean  "isInsured"
    t.decimal  "grand_total",               precision: 18, scale: 3
    t.string   "ref_1",         limit: 255
    t.string   "ref_2",         limit: 255
    t.string   "ref_3",         limit: 255
  end

  create_table "subscriptions", force: :cascade do |t|
    t.string   "email",      limit: 255
    t.string   "comments",   limit: 255
    t.string   "ref_1",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "userdocs", force: :cascade do |t|
    t.string   "uid",                  limit: 255
    t.string   "type",                 limit: 255
    t.string   "url",                  limit: 255
    t.string   "picture_file_name",    limit: 255
    t.string   "picture_content_type", limit: 255
    t.integer  "picture_file_size",    limit: 4
    t.datetime "picture_updated_at"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider",               limit: 255,   default: "email",        null: false
    t.string   "uid",                    limit: 255,   default: "",             null: false
    t.string   "encrypted_password",     limit: 255,   default: "",             null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,     default: 0,              null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.string   "name",                   limit: 255
    t.string   "nickname",               limit: 255
    t.string   "image",                  limit: 255
    t.string   "email",                  limit: 255
    t.text     "tokens",                 limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phone",                  limit: 255
    t.string   "address",                limit: 255
    t.string   "aadhar_link",            limit: 255
    t.string   "voterid_link",           limit: 255
    t.string   "dl_link",                limit: 255
    t.string   "verified",               limit: 255,   default: "Not Verified"
    t.string   "oauth_token",            limit: 255
    t.datetime "oauth_expires_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true, using: :btree

  create_table "volumetrics", force: :cascade do |t|
    t.decimal  "coefficient",             precision: 10, scale: 6
    t.string   "updated_by",  limit: 255
    t.boolean  "status"
    t.string   "comments",    limit: 255
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.string   "name",        limit: 255
  end

end
