json.array!(@blood_sugar_readings) do |blood_sugar_reading|
  json.extract! blood_sugar_reading, :id, :value, :read_time
  json.url blood_sugar_reading_url(blood_sugar_reading, format: :json)
end
