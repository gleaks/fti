Rails.application.routes.draw do
  get 'welcome/index'
  root 'welcome#index'
  
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  
  resources :customers
  resources :orders
  resources :products
  resources :assemblies
  resources :parts
  resources :categories
end
