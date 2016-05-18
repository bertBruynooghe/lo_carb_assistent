json.array!(@nutrients) do |nutrient|
  json.extract! nutrient, :id, :name, :calories, :carbs, :proteins, :fat
  json.url nutrient_url(nutrient, format: :json)
end
