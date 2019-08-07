Rails.application.routes.draw do
  get 'welcome/index'
  root 'welcome#index'

  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  get 'customers/modal' => 'customers#modal', :as => :customer_modal
  get 'categories/modal' => 'categories#modal', :as => :category_modal
  get 'octopart/:id' => 'octopart#index', :as => :octopart
  get 'invoices/:id' => 'orders#invoice', :as => :invoices
  resources :customers
  resources :orders
  resources :products
  resources :assemblies
  resources :parts
  resources :categories
  resources :vendorparts
  resources :vendors
  resources :stocks
  resources :modulelogs
  resources :locations

  resources :materials, only: [:index]

end
