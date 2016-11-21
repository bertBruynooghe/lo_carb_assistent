class InsulinDose < ApplicationRecord
  belongs_to :insulin, required: true
end
