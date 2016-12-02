module FloatFormConcern
  extend ActiveSupport::Concern

  class FloatPartsAccessor
    def initialize(method)
      @method = method
    end

    def set_fractional_part(resource, value)
      integral_part = get_integral_part(resource)
      new_value = compose_float(integral_part, value)
      resource.send("#{@method}=", new_value)
    end

    def set_integral_part(resource, value)
      fractional_part = get_fractional_part(resource)
      new_value = compose_float(value, fractional_part)
      resource.send("#{@method}=", new_value)
    end

    def get_integral_part(resource)
      float_parts(resource).first
    end

    def get_fractional_part(resource)
      float_parts(resource).last
    end

    private

    def compose_float(integral_part, fractional_part)
      "#{integral_part}.#{fractional_part}".to_f
    end

    def float_parts(resource)
      parts = resource.send(@method).to_s.split('.').map(&:to_i)

      # We need the nil construct because of usability: if an input field is set to nil,
      # you need to explicitly select and change its content, while a nil value allows you to focus the input field
      # and you can type right away. You can off course implement this behaviour in javascript, but this way it
      # also works without javascript
      parts.map{ |i| i == 0 ? nil : i }
    end
  end

  module ClassMethods
    def split_float(*methods)
      methods.each do |m|
         accessor = FloatPartsAccessor.new(m)
         define_method("#{m}_integral")    { accessor.get_integral_part(self) }
         define_method("#{m}_fractional")  { accessor.get_fractional_part(self) }
         define_method("#{m}_integral=")   { |v| accessor.set_integral_part(self, v) }
         define_method("#{m}_fractional=") { |v| accessor.set_fractional_part(self, v) }
      end
    end

    def expanded_float_keys
      keys = self.float_keys
      keys.map{ |k| :"#{k}_integral"} + keys.map{ |k| :"#{k}fractional"}
    end
  end
end
