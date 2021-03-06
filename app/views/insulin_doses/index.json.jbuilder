json.array!(@insulin_doses) do |insulin_dose|
  json.extract! insulin_dose, :id, :bolus, :dose, :application_time
  json.url insulin_dose_url(insulin_dose, format: :json)
end
