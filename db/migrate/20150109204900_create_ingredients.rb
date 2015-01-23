class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
      t.text :name
      t.decimal :calories
      t.decimal :carbs
      t.decimal :proteins
      t.decimal :fat

      t.timestamps
    end
  end
end
