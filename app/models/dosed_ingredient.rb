class DosedIngredient < ActiveRecord::Base
  belongs_to :meal

  def assign_attributes (new_attributes)
    %w(quantity carbs proteins fat calories).each do |key|
      new_attributes[key] = 0 if new_attributes[key].blank?
    end

    if new_attributes.delete(:save)
      existing = Ingredient.find_by(name: new_attributes[:name])
      stored_ingredient_attributes = new_attributes.dup.delete_if do |k, _|
        ['meal_id', 'quantity'].include?(k).tap{|r| puts "delete: #{r}"}
      end
      if existing
        existing.update_attributes(stored_ingredient_attributes)
      else
        Ingredient.create(stored_ingredient_attributes)
      end
    end
    super
  end
end
