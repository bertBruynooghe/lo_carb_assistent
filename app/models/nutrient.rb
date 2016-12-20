class Nutrient < ApplicationRecord
  scope :name_containing, ->(search_string) do
    where search_string ? Nutrient.arel_table[:name].matches("%#{search_string}%") : nil
  end

  include FloatFormConcern

  def self.float_keys
    %i(carbs proteins fat calories)
  end

  split_float *float_keys
end
