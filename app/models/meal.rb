class Meal < ApplicationRecord
  has_many :ingredients, inverse_of: :meal, dependent: :destroy
  accepts_nested_attributes_for :ingredients, allow_destroy: true

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

  def consumption_day
    (consumption_time || DateTime.now).strftime('%A')
  end

  def consumption_time_iso
    consumption_time.try(:iso8601)
  end

  scope :for_week, -> (start_day) {
    if start_day
      start_day = DateTime.iso8601(start_day)
      where('consumption_time< ?', start_day + 7.days).where('consumption_time>= ?', start_day)
    else
      where('consumption_time> ?', Date.today - (Date.today.cwday + 6).days)
    end
  }

  private

  def sum(attr_name)
    ingredients.reduce(0.0) do |m, nutrient|
      m + ((nutrient.send(attr_name) || 0.0) * (nutrient.quantity || 0.0) / 100.0)
    end
  end
end
