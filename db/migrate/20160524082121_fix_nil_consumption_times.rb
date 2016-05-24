class FixNilConsumptionTimes < ActiveRecord::Migration
  def change
    Meal.where(consumption_time: nil).each do |m|
      m.consumption_time = m.created_at
      m.save
    end
  end
end
