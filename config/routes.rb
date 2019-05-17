Rails.application.routes.draw do
  devise_for :users
  root 'orders#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :orders do
    resources :notes, only: [:new, :create]
    resources :receivings, only: [:new, :create]
    resources :payments, only: [:new, :create]
  end
  resources :repair_rates, only: [:index, :show]
end
