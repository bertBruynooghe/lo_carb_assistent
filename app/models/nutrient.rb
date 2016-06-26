class Nutrient < ActiveRecord::Base
  include SplitFloatConcern

  split_float *%i(calories carbs proteins fat)

  def assign_attributes (new_attributes)
    %w(carbs proteins fat calories).each do |key|
      new_attributes["#{key}_integral"] = 0 if new_attributes["#{key}_integral"].blank?
      new_attributes["#{key}_fractional"] = 0 if new_attributes["#{key}_fractional"].blank?
    end
  end
end
