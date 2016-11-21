class Ingredient < ApplicationRecord
  belongs_to :meal, required: true
  validates_presence_of :meal, inverse_of: :ingredients

  #TODO: this looks like a controller issue rather than a model issue?
  def assign_attributes (new_attributes)
    %w(carbs proteins fat calories).each do |key|
      new_attributes[key] = 0 if new_attributes[key].blank?
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
