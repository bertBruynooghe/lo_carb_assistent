class CreateBloodSugarReadings < ActiveRecord::Migration
  def change
    create_table :blood_sugar_readings do |t|
      t.integer :value
      t.datetime :read_time

      t.timestamps null: false
    end
  end
end
