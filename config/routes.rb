Rails.application.routes.draw do
  get 'images/new'
  get 'images/create'
  devise_for :users, controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations'
      }
  root 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :orders do
    resources :order_items, only: [:new, :create]
    resources :images, only: [:new, :create]
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
  resources :order_items, only: :destroy
  resources :open_calls do
    resources :orders, only: :new
  end
  resources :user_onlines, only: [:create, :destroy]

  namespace :packing_slip do
    resources :orders, only: :show
  end
  get "orders/:order_id/shippings", to: "shippings#create_bnp", as: :create_bnp
end
