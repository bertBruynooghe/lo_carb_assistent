Rails.application.routes.draw do
  resources :other_meals
  resources :insulin_doses
  resources :insulins
  resources :blood_sugar_readings
  devise_for :users
  root to: redirect('meals')

  resources :ingredients, only: %i(new create)

  resources :meals, except: %i(edit), shallow: true do
    resources :ingredients, only: %i(show update)
  end

  resources :nutrients

  get 'appcache.manifest', to: 'app_cache#index'
  get 'cache_loader', to: 'cache_loader#index'
end
