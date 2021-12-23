class AddIndexToMealsClientToken < ActiveRecord::Migration[6.1]
  def change
    add_index :meals, :client_token
  end
end
