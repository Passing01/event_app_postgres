Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users
  resources :events, only: [:index, :new, :create, :show]
  root 'events#index'
  resources :users, only: [:show]
end
