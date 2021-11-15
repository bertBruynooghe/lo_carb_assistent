Rails.application.routes.draw do
  get 'app', to: 'webmanifest#index'
  devise_for :users
  root to: redirect('meals')
  resources :meals
  resources :nutrients
end
