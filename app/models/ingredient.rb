class Ingredient < ActiveRecord::Base
  def assign_attributes (new_attributes)
    %w(carbs proteins fat calories).each do |key|
      new_attributes.store(key, 0) if new_attributes.fetch(key).blank?
    end
  end
end
