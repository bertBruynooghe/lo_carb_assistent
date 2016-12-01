class Nutrient < ApplicationRecord
  include FloatFormConcern

  def self.float_keys
    %i(carbs proteins fat calories)
  end

  split_float *float_keys
end
