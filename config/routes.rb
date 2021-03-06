Rails.application.routes.draw do
  resources 'uploads', only: %i(new create)

  resources :insulin_doses
  resources :insulins
  resources :blood_sugar_readings
  devise_for :users
  root to: redirect('meals')

  resources :meals
  resources :nutrients
  resources :graphs

  get 'appcache.manifest', to: 'app_cache#index'
  get 'cache_loader', to: 'cache_loader#index'
end
