class AddManualToBloodSugarReading < ActiveRecord::Migration[5.0]
  def change
    add_column :blood_sugar_readings, :manual, :boolean, default: true
  end
end
