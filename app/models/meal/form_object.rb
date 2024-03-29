class Meal
  class FormObject
    attr_reader :ingredient_index
    attr_reader :ingredient_action

    def initialize(meal_or_attributes = {})
      if meal_or_attributes.is_a?(::Meal)
        @meal = meal_or_attributes
      else
        @meal = ::Meal.new
        assign_attributes(meal_or_attributes)
      end
    end

    # custom behaviour of the Meal::FormObject
    def assign_attributes(new_attributes)
      extract_ingredients_action_args(new_attributes)
      if ingredient_action == :delete
        new_attributes[:ingredients_attributes][ingredient_index.to_s][:_destroy] = '1'
      end
      if (new_attributes.dig(:ingredients_attributes, ingredient_index.to_s)||{}).delete(:save_as_nutrient) == '1'
        Nutrient.create(new_attributes[:ingredients_attributes][ingredient_index.to_s].select do |k, _|
          (Nutrient.float_keys.map{ |k| "#{k}_integral" } + Nutrient.float_keys.map{ |k| "#{k}_fractional" } + ['name']).include?(k)
        end)
      end
      @meal.assign_attributes(new_attributes)
    end

    def selected_ingredient
      ingredients[ingredient_index] || Ingredient.new
    end

    def selected_ingredient_present?
      ingredients[ingredient_index].present?
    end

    def method_missing(method, *args)
      @meal.send(method, *args)
    end

    def self.find(*args)
      self.new(Meal.find(*args))
    end

    def self.method_missing(method, *args)
      ::Meal.send(method, *args)
    end

    # needed for proper form submission path in form view
    delegate :persisted?, to: :meal

    # needed for fields_for functionality in form view
    delegate :ingredients, :ingredients=, :ingredients_attributes=, to: :meal

    private

    attr_reader :meal

    def extract_ingredients_action_args(new_attributes)
      (new_attributes[:ingredients_attributes] || {}).reject! do |index, ingredient_attributes|
        extract_ingredient_action_args(index, ingredient_attributes).empty?
      end
    end

    def extract_ingredient_action_args(index, ingredient_attributes)
      if value = ingredient_attributes.delete('commit')
        @ingredient_index = index.to_i
        @ingredient_action = value.to_sym
      end
      ingredient_attributes
    end
  end
end
