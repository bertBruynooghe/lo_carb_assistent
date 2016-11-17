Rails.application.routes.draw do
  resources :insulin_doses
  resources :insulins
  resources :blood_sugar_readings
  devise_for :users
  root to: redirect('meals')

  resources :meals, except: %i(new edit), shallow: true do
    resources :ingredients, except: %i(index new edit)
  end

  resources :nutrients

  get 'appcache.manifest', to: 'app_cache#index'
  get 'cache_loader', to: 'cache_loader#index'
end
