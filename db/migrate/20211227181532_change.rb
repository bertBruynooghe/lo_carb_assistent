class Change < ActiveRecord::Migration[6.1]
  def up
    change_column :nutrients, :calories, :decimal, :precision => 5, :scale => 2, null: false
  end

  def down
    change_column :nutrients, :calories, :float, null: false
  end
end
