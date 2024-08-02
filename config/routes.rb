Rails.application.routes.draw do
  namespace :admin do
    get 'events/index'
    get 'events/show'
    get 'events/edit'
    get 'events/update'
    get 'events/destroy'
  end
  namespace :admin do
    get 'event_submissions/index'
    get 'event_submissions/show'
    get 'event_submissions/edit'
    get 'event_submissions/update'
  end
  namespace :admin do
    get 'users/index'
    get 'users/show'
    get 'users/edit'
    get 'users/update'
    get 'users/destroy'
  end
  namespace :admin do
    get 'dashboard/index'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users
  resources :events, only: [:index, :new, :create, :show]
  root 'events#index'
  resources :users, only: [:show, :show, :edit, :update, :destroy]

  resources :events do
    resources :attendances, only: [:new, :create]
  end

  namespace :admin do
  resources :users, only: [:index, :show, :edit, :update, :destroy]
  resources :event_submissions, only: [:index, :show, :edit, :update]
    root to: "dashboard#index"
  end

end

