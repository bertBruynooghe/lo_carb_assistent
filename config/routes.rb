Rails.application.routes.draw do
  resources :insulin_doses
  resources :insulins
  resources :blood_sugar_readings
  devise_for :users
  root to: 'meals#index'

  resources :meals do
    resources :ingredients, except: :index
  end

  resource :ingredient, only: :new do
  end

  resources :nutrients
end
