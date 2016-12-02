json.array!(@nutrients) do |nutrient|
  json.extract! nutrient, :id, :name, *Nutrient.float_keys
  json.url nutrient_url(nutrient, format: :json)
end
