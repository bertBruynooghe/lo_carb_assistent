class Nutrient < ApplicationRecord
  def assign_attributes (new_attributes)
    %w(carbs proteins fat calories).each do |method|
      new_attributes[method] = 0 if new_attributes[method].blank?
      i = new_attributes["#{method}_integral"]
      new_attributes[method] = i unless i.blank?
      f = new_attributes["#{method}_fractional"]
      new_attributes[method] = "#{new_attributes[method]}.#{f}" unless f.blank?
    end
    super
  end
end
