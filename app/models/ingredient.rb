class Ingredient < ApplicationRecord
  belongs_to :meal
  #validates_presence_of :meal, inverse_of: :ingredients

  include FloatFormConcern
  def self.float_keys
    Nutrient.float_keys + %i(quantity)
  end
  split_float *float_keys
end
