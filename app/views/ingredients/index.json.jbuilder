json.array!(@ingredients) do |ingredient|
  json.extract! ingredient, :id, :name, :calories, :carbs, :proteins, :fat
  json.url ingredient_url(ingredient, format: :json)
end
