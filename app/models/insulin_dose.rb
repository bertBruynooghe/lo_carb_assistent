class InsulinDose < ApplicationRecord
  belongs_to :insulin, required: true

  include FloatFormConcern
  split_float :dose
end
