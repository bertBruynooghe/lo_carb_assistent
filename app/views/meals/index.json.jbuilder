json.array!(@meals) do |meal|
  json.extract! meal, :id, :creation_time
  json.url meal_url(meal, format: :json)
end
