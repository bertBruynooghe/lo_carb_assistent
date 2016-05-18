class CreateInsulinDoses < ActiveRecord::Migration
  def change
    create_table :insulin_doses do |t|
      t.integer :insulin_id
      t.decimal :dose
      t.datetime :application_time

      t.timestamps null: false
    end
  end
end
