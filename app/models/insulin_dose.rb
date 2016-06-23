class InsulinDose < ActiveRecord::Base
  belongs_to :insulin
  default_scope { order(application_time: :desc) }

  def dose_fractional
    dose_parts.last.to_i
  end

  def dose_integral
    dose_parts.first.to_i
  end

  def dose_fractional=(value)
    self.dose = "#{dose_parts.first}.#{value}".to_f
  end

  def dose_integral=(value)
    self.dose = "#{value}.#{dose_parts.last}".to_f
  end

  def save
    byebug
    super
  end

  private
  def dose_parts
    dose.to_f.to_s.split('.')
  end
end
