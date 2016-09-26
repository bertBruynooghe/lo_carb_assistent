class InsulinDose < ActiveRecord::Base
  belongs_to :insulin, required: true
end
