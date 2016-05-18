class RenameDosedIngredientToMealComponent < ActiveRecord::Migration
  def change
    rename_table(:dosed_ingredients, :meal_components)
  end
end
