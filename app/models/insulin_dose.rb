class InsulinDose < ApplicationRecord
  scope :for_week, -> (start_day) {
    if start_day
      start_day = DateTime.iso8601(start_day)
      where('application_time< ?', start_day + 7.days).where('application_time>= ?', start_day)
    else
      where('application_time> ?', Date.today - (Date.today.cwday + 6).days)
    end
  }

  include FloatFormConcern
  split_float :dose
end
