class CreateInsulinDoses < ActiveRecord::Migration
  def change
    create_table "blood_sugar_readings", force: :cascade do |t|
      t.integer  "value"
      t.datetime "read_time"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
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
      t.integer  "insulin_id"
      t.decimal  "dose"
      t.datetime "application_time"
      t.datetime "created_at",       null: false
      t.datetime "updated_at",       null: false
    end

    create_table "insulins", force: :cascade do |t|
      t.text     "name"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

    create_table "meals", force: :cascade do |t|
      t.datetime "creation_time"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "nutrients", force: :cascade do |t|
      t.text     "name"
      t.decimal  "calories"
      t.decimal  "carbs"
      t.decimal  "proteins"
      t.decimal  "fat"
      t.datetime "created_at"
      t.datetime "updated_at"
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
    end
  end
end
