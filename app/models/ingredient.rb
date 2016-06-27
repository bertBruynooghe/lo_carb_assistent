class Ingredient < ActiveRecord::Base
  belongs_to :meal
  validates_presence_of :meal, inverse_of: :ingredients

  #TODO: this looks like a controller issue rather than a model issue?
  def assign_attributes (new_attributes)
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
