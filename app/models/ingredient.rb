class Ingredient < ApplicationRecord
  belongs_to :meal, required: true
  validates_presence_of :meal, inverse_of: :ingredients

  include FloatFormConcern
  split_float *%i(quantity carbs proteins fat calories)
end
