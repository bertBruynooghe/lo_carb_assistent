module ActionController
  class Parameters
    def join_split_floats(*methods)
      methods.each{ |method| join_split_float(method) }
      self
    end

    private

    def join_split_float(method)
      store(method, delete("#{method}_integral"))
      f = delete("#{method}_fractional")
      self[method] = "#{fetch(method)}.#{f}" unless f.blank?
    end
  end
end
