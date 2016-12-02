json.extract! @nutrient, :id, :name, :created_at, :updated_at, *Nutrient.float_keys
