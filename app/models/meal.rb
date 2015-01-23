class Meal < ActiveRecord::Base
  has_many :dosed_ingredients, dependent: :destroy
end
