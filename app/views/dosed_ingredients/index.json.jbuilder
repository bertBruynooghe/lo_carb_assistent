json.array!(@dosed_ingredients) do |dosed_ingredient|
  json.extract! dosed_ingredient, :id, :quantity, :name, :calories, :carbs, :proteins, :fat
  json.url dosed_ingredient_url(dosed_ingredient, format: :json)
end
