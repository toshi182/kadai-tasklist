Rails.application.routes.draw do
  root to: 'toppages#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'signup', to: 'users#new'
  resources :users, only: [:show, :new, :create]

  # resources :tasks, only: [:index, :show, :new, :create,, :edit, :update, :destroy]
  # resources :tasks と書くだけで、index～destroyまでが自動的に作られる
  resources :tasks
end