module SplitFloatConcern
  extend ActiveSupport::Concern

  class_methods do
    def split_float(*methods)
      methods.each {|method| define_partial_accessors(method)}
    end

    private

    def define_partial_accessors(method)
      define_method("#{method}_integral") { integral_part(method) }
      define_method("#{method}_fractional") { fractional_part(method) }
      define_integral_part_writer(method)
      define_fractional_part_writer(method)
    end

    def define_fractional_part_writer(method)
      define_method("#{method}_fractional=") do |value|
        self.send("#{method}=", "#{value}.#{fractional_part(method)}".to_f)
      end
    end

    def define_integral_part_writer(method)
      define_method("#{method}_integral=") do |value|
        self.send("#{method}=", "#{integral_part(method)}.#{value}".to_f)
      end
    end
  end

  private

  def integral_part(method)
    float_parts(method).first.to_i
  end

  def fractional_part(method)
    float_parts(method).last.to_i
  end

  def float_parts(method)
    self.send(method).to_f.to_s.split('.')
  end
end
