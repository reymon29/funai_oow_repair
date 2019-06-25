Rails.application.routes.draw do
  devise_for :users, controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations'
      }
  root 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :orders do
    resources :order_items, only: [:new, :create]
    resources :notes, only: [:new, :create]
    resources :receivings, only: [:new, :create]
    resources :payments, only: [:new, :create]
    resources :repairs, only: [:new, :create]
    resources :shippings, only: [:new, :create] do
      member do
        get "resend"
      end
    end
  end
  resources :shippings, only: [:edit, :update]
  resources :order_items, only: :destroy
  resources :open_calls do
    resources :orders, only: :new
  end
  resources :user_onlines, only: [:create, :destroy]
end
