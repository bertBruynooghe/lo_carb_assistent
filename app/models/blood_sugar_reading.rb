class BloodSugarReading < ActiveRecord::Base
  validates :value, :read_time, presence: true
  default_scope { order(read_time: :desc) }
end
