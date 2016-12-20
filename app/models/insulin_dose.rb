class InsulinDose < ApplicationRecord
  include FloatFormConcern
  split_float :dose
end
