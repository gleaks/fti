Rails.application.routes.draw do
  resources :modulelogs
  resources :locations
  get 'welcome/index'
  root 'welcome#index'

  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  get 'customers/modal' => 'customers#modal', :as => :customer_modal
  resources :customers
  resources :orders
  resources :products
  resources :assemblies
  resources :parts
  resources :categories

  resources :materials, only: [:index]

end
