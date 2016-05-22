class InsulinDose < ActiveRecord::Base
  default_scope { order(application_time: :desc) }
end
