Rails.application.routes.draw do
  devise_for :users
  root 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :orders do
    resources :order_items, only: [:new, :create]
    resources :notes, only: [:new, :create]
    resources :receivings, only: [:new, :create]
    resources :payments, only: [:new, :create]
    resources :repairs, only: [:new, :create]
    resources :shippings, only: [:new, :create]
  end
  resources :order_items, only: :destroy

end
