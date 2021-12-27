# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_12_27_181532) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ingredients", force: :cascade do |t|
    t.decimal "quantity"
    t.text "name"
    t.float "calories"
    t.decimal "carbs"
    t.decimal "proteins"
    t.decimal "fat"
    t.integer "meal_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "meals", force: :cascade do |t|
    t.datetime "creation_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "consumption_time"
    t.integer "client_token"
    t.index ["client_token"], name: "index_meals_on_client_token"
  end

  create_table "nutrients", force: :cascade do |t|
    t.text "name"
    t.decimal "calories", precision: 5, scale: 2, null: false
    t.decimal "carbs"
    t.decimal "proteins"
    t.decimal "fat"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", limit: 255, default: "", null: false
    t.string "encrypted_password", limit: 255, default: "", null: false
    t.string "reset_password_token", limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
