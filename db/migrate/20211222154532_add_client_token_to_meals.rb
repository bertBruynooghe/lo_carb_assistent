class AddClientTokenToMeals < ActiveRecord::Migration[6.1]
  # client_token is needed to have an almost unique id in the urls 
  # to point to a resource that might or might not be overridden by the client database
  def change
    add_column :meals, :client_token, :integer
  end
end
