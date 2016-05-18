class RenameIngredientToNutrient < ActiveRecord::Migration
  def change
    rename_table(:ingredients, :nutrients)
  end
end
