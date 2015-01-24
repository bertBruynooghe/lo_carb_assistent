class Meal < ActiveRecord::Base
  has_many :dosed_ingredients, dependent: :destroy
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

  private

  def sum(attr_name)
    dosed_ingredients.reduce(0.0) do |m, ingredient|
      m + (ingredient.send(attr_name) * ingredient.quantity / 100.0)
    end
  end
end
