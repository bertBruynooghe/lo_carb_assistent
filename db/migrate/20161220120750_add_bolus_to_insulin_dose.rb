class AddBolusToInsulinDose < ActiveRecord::Migration[5.0]
  class InsulinDose < ApplicationRecord
  end
  def change
    add_column :insulin_doses, :bolus, :boolean, default: true
    InsulinDose.find_each do |dose|
      dose.update(bolus: dose.insulin_id == 1)
    end
    remove_column :insulin_doses, :insulin_id
    drop_table :insulins
  end
end
