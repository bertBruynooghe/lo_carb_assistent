class BloodSugarReading < ApplicationRecord
  validates :value, :read_time, presence: true

  scope :for_week, -> (start_day) {
    if start_day
      start_day = DateTime.iso8601(start_day)
      where('read_time < ?', start_day + 7.days).where('read_time >= ?', start_day)
    else
      where('read_time > ?', 7.days.ago)
    end
  }
end
