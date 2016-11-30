class Nutrient < ApplicationRecord
  include FloatFormConcern
  split_float *%i(carbs proteins fat calories)
end
