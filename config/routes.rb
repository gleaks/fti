Rails.application.routes.draw do
  resources :customers
  resources :orders
  resources :products
  resources :assemblies
  resources :parts
  resources :categories
  get 'welcome/index'
  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
