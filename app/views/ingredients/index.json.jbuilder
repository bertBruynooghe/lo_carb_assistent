json.array!(@ingredients) do |ingredient|
  json.extract! ingredient, :id, :quantity, :name, :calories, :carbs, :proteins, :fat
  json.url ingredient_url(ingredient, format: :json)
end
