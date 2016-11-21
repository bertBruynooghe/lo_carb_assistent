class BloodSugarReading < ApplicationRecord
  validates :value, :read_time, presence: true
end
