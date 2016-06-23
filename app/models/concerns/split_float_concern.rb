module SplitFloatConcern
  extend ActiveSupport::Concern

  class_methods do
    def split_float(method)
      define_method("#{method}_fractional") do
        float_parts(method).last.to_i
      end

      define_method("#{method}_integral") do
        float_parts(method).first.to_i
      end

      define_method("#{method}_fractional=") do |value|
        self.send("#{method}=", "#{float_parts(method).first}.#{value}".to_f)
      end

      define_method("#{method}_integral=") do |value|
        self.send("#{method}=", "#{value}.#{float_parts(method).last}".to_f)
      end
    end
  end

  private
  def float_parts(method)
    self.send(method).to_f.to_s.split('.')
  end
end
