class DropSubjectsTable < ActiveRecord::Migration[6.1]
  def change
    remove_reference :meals, :subject, index: true, foreign_key: true
    remove_reference :nutrients, :subject, index: true, foreign_key: true
    remove_reference :users, :subject, index: true, foreign_key: true
    drop_table :subjects do |t|
      t.string "name"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  end
end
