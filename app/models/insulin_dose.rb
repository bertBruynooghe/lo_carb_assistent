class InsulinDose < ActiveRecord::Base
  include SplitFloatConcern
  belongs_to :insulin

  #TODO: do this in the controller
  default_scope { order(application_time: :desc) }

  split_float :dose

  private
  def dose_parts
    dose.to_f.to_s.split('.')
  end
end
