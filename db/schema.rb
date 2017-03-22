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

ActiveRecord::Schema.define(version: 20170321073934) do

  create_table "account_email_tokens", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",                                         null: false
    t.string   "email_for_index",                               null: false
    t.text     "value",           limit: 65535,                 null: false
    t.boolean  "used",                          default: false, null: false
    t.boolean  "agreement",                     default: false, null: false
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
  end

  create_table "password_tokens", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id",                                  null: false
    t.text     "value",      limit: 65535,                 null: false
    t.boolean  "used",                     default: false, null: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.index ["user_id"], name: "index_password_tokens_on_user_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",                             null: false
    t.string   "email_for_index",                   null: false
    t.string   "family_name",                       null: false
    t.string   "given_name",                        null: false
    t.string   "family_name_kana",                  null: false
    t.string   "given_name_kana",                   null: false
    t.string   "hashed_password"
    t.integer  "gender",            default: 0,     null: false
    t.date     "birthday"
    t.string   "company",                           null: false
    t.string   "department",                        null: false
    t.string   "official_position",                 null: false
    t.boolean  "suspended",         default: false, null: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.index ["family_name_kana", "given_name_kana"], name: "index_users_on_family_name_kana_and_given_name_kana", using: :btree
  end

end
