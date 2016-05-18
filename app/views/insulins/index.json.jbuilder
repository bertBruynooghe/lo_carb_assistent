json.array!(@insulins) do |insulin|
  json.extract! insulin, :id, :name
  json.url insulin_url(insulin, format: :json)
end
