class RenameMealComponentToIngredient < ActiveRecord::Migration
  def change
    rename_table(:meal_components, :ingredients)
  end
end
