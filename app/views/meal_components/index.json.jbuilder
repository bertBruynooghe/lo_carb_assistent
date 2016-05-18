json.array!(@meal_components) do |meal_component|
  json.extract! meal_component, :id, :quantity, :name, :calories, :carbs, :proteins, :fat
  json.url meal_component_url(meal_component, format: :json)
end
