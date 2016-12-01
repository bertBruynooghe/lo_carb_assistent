module Form
  class Ingredient
    def initialize(args)
      if args.is_a?(::Ingredient)
        @ingredient = args
      else
        @ingredient = ::Ingredient.new
        assign_attributes(args)
      end
    end

    def update(attributes)
      assign_attributes(attributes)
      save
    end

    def assign_attributes(attributes)
      nutrient_float_keys  = %w(carbs calories proteins fat)
      nutrient_float_keys = nutrient_float_keys.map{|k| "#{k}_integral"} + nutrient_float_keys.map{|k| "#{k}_fractional"}
      if attributes[:save_as_favorite]
        @nutrient = Nutrient.new(attributes.select{ |k, _| (nutrient_float_keys + ['name']).include?(k) })
      end
      @ingredient.assign_attributes(attributes.reject{ |k, _| k == 'save_as_favorite' })
    end

    def save
      result = @nutrient.nil? || @nutrient.save
      result && @ingredient.valid?
    end

    def method_missing(method, *args)
      @ingredient.send(method, *args)
    end

    def self.method_missing(method, *args)
      ::Ingredient.send(method, *args)
    end
  end
end
