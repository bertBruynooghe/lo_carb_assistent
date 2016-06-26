class Ingredient < ActiveRecord::Base
  include SplitFloatConcern

  belongs_to :meal
  validates_presence_of :meal, inverse_of: :ingredients

  split_float *%i(calories carbs proteins fat)

  #TODO: this looks like a controller issue rather than a model issue?
  def assign_attributes (new_attributes)
    %w(carbs proteins fat calories).each do |key|
      new_attributes["#{key}_integral"] = 0 if new_attributes["#{key}_integral"].blank?
      new_attributes["#{key}_fractional"] = 0 if new_attributes["#{key}_fractional"].blank?
    end

    if new_attributes.delete(:save_as_favorite)
      favorite_nutrient = Nutrient.find_or_initialize_by(name: new_attributes[:name])
      new_attributes.each do |k,v|
        favorite_nutrient.send("#{k}=", v) unless %w(meal_id quantity).include?(k)
      end
      favorite_nutrient.save
    end
    super
  end
end
