module Forms
  class Meal
    attr_reader :ingredient_index
    attr_reader :ingredient_action

    def initialize(meal_or_attributes)
      if meal_or_attributes.is_a?(::Meal)
        @meal = meal_or_attributes
      else
        @meal = ::Meal.new
        assign_attributes(meal_or_attributes)
      end
    end

    # custom behaviour of the Forms::Meal
    def assign_attributes(new_attributes)
      extract_ingredients_action_args(new_attributes)
      if ingredient_action == :delete
        new_attributes[:ingredients_attributes][ingredient_index.to_s][:_destroy] = '1'
      end
      @meal.assign_attributes(new_attributes)
    end

    def save(*args)
      # don't save yet if we're coming if we're about to start/finishing an ingredient edit
      return false unless @ingredient_index.nil?
      @meal.save
    end

    def method_missing(method, *args)
      @meal.send(method, *args)
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
