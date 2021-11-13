class DropObsoleteTables < ActiveRecord::Migration[6.1]
  def change
    drop_table :blood_sugar_readings do |t|
      t.integer "value"
      t.datetime "read_time"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "subject_id"
      t.boolean "manual", default: true
      t.index ["subject_id"], name: "index_blood_sugar_readings_on_subject_id"
      t.foreign_key "subjects"
    end
    drop_table :insulin_doses do |t|
      t.decimal "dose"
      t.datetime "application_time"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "subject_id"
      t.boolean "bolus" , default: true
      t.index ["subject_id"], name: "index_insulin_doses_on_subject_id"
      t.foreign_key "insulin_doses", "subjects"
    end
  end
end
