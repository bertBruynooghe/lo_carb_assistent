class AddConsumptionTimeToMeal < ActiveRecord::Migration
  def change
    add_column :meals, :consumption_time, :datetime
    Meal.where(consumption_time: nil).each do |m|
      m.consumption_time = m.created_at
      m.save
    end
  end
end
