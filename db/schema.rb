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

ActiveRecord::Schema.define(version: 20161220120750) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "blood_sugar_readings", force: :cascade do |t|
    t.integer  "value"
    t.datetime "read_time"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "subject_id"
    t.boolean  "manual",     default: true
    t.index ["subject_id"], name: "index_blood_sugar_readings_on_subject_id", using: :btree
  end

  create_table "ingredients", force: :cascade do |t|
    t.decimal  "quantity"
    t.text     "name"
    t.float    "calories"
    t.decimal  "carbs"
    t.decimal  "proteins"
    t.decimal  "fat"
    t.integer  "meal_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "insulin_doses", force: :cascade do |t|
    t.decimal  "dose"
    t.datetime "application_time"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "subject_id"
    t.boolean  "bolus",            default: true
    t.index ["subject_id"], name: "index_insulin_doses_on_subject_id", using: :btree
  end

  create_table "meals", force: :cascade do |t|
    t.datetime "creation_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "consumption_time"
    t.integer  "subject_id"
    t.index ["subject_id"], name: "index_meals_on_subject_id", using: :btree
  end

  create_table "nutrients", force: :cascade do |t|
    t.text     "name"
    t.decimal  "calories"
    t.decimal  "carbs"
    t.decimal  "proteins"
    t.decimal  "fat"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "subject_id"
    t.index ["subject_id"], name: "index_nutrients_on_subject_id", using: :btree
  end

  create_table "subjects", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "subject_id"
    t.index ["subject_id"], name: "index_users_on_subject_id", using: :btree
  end

  add_foreign_key "blood_sugar_readings", "subjects"
  add_foreign_key "insulin_doses", "subjects"
  add_foreign_key "meals", "subjects"
  add_foreign_key "nutrients", "subjects"
  add_foreign_key "users", "subjects"
end
