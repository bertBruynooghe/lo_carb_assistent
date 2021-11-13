class DropSubjectsTable < ActiveRecord::Migration[6.1]
  def change
    drop_table :subjects do |t|
      t.string "name"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  end
end
