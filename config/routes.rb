Rails.application.routes.draw do
  root to: 'toppages#index'
  get 'toppages/index'
  get 'users/index'
  get 'users/show'
  get 'users/new'
  get 'users/create'
  get 'signup', to: 'users#new'
  resources :tasks
  resources :users, only: [:index, :show, :new, :create]
end
