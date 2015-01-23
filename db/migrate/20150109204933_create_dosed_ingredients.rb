class CreateDosedIngredients < ActiveRecord::Migration
  def change
    create_table :dosed_ingredients do |t|
      t.decimal :quantity
      t.text :name
      t.float :calories
      t.decimal :carbs
      t.decimal :proteins
      t.decimal :fat
      t.belongs_to :meal, index: true

      t.timestamps
    end
  end
end
