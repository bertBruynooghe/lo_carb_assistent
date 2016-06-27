class InsulinDose < ActiveRecord::Base
  belongs_to :insulin

  #TODO: do this in the controller
  default_scope { order(application_time: :desc) }

  private
  def dose_parts
    dose.to_f.to_s.split('.')
  end
end
