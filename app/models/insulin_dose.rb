class InsulinDose < ActiveRecord::Base
  belongs_to :insulin
  default_scope { order(application_time: :desc) }
end
