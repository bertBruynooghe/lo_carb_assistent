class CreateMeals < ActiveRecord::Migration
  def change
    create_table :meals do |t|
      t.datetime :creation_time

      t.timestamps
    end
  end
end
