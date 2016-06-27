class BloodSugarReading < ActiveRecord::Base
  validates :value, :read_time, presence: true
end
