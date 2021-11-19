Rails.application.routes.draw do
  get 'app', to: 'webmanifest#index'
  get 'service_worker', to: 'service_worker#index'
  devise_for :users
  root to: redirect('meals')
  resources :meals
  resources :nutrients
end
