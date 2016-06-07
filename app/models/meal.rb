class Meal < ActiveRecord::Base
  has_many :ingredients, inverse_of: :meal, dependent: :destroy
  accepts_nested_attributes_for :ingredients, allow_destroy: true

  default_scope { order(consumption_time: :desc) }

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
    ingredients.reduce(0.0) do |m, ingredient|
      m + ((ingredient.send(attr_name) || 0.0) * ingredient.quantity / 100.0)
    end
  end
end
