class MealComponent < ActiveRecord::Base
  belongs_to :meal

  def assign_attributes (new_attributes)
    %w(quantity carbs proteins fat calories).each do |key|
      new_attributes[key] = 0 if new_attributes[key].blank?
    end

    if new_attributes.delete(:save)
      favorite_ingredient = Ingredient.find_or_initialize_by(name: new_attributes[:name])
      new_attributes.each do |k,v|
        favorite_ingredient.send("#{k}=", v) unless %w(meal_id quantity).include?(k)
      end
      favorite_ingredient.save
    end
    super
  end
end
