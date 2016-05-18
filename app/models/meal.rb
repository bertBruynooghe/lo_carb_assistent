class Meal < ActiveRecord::Base
  has_many :meal_components, dependent: :destroy
  def calories
    sum(:calories)
  end

  def carbs
    sum(:carbs)
  end

  def proteins
    sum(:proteins)
  end

  def fat
    sum(:fat)
  end

  def glucoseEquivalent
    carbs + proteins / 5.0
  end

  private

  def sum(attr_name)
    meal_components.reduce(0.0) do |m, nutrient|
      m + (nutrient.send(attr_name) * nutrient.quantity / 100.0)
    end
  end
end
