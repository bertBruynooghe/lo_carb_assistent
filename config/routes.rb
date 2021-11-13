Rails.application.routes.draw do
  devise_for :users
  root to: redirect('meals')
  resources :meals
  resources :nutrients
end
