Rails.application.routes.draw do

  root to: 'toppages#index'
  
  get 'login', to: 'tasks#new'
  post 'login', to: 'tasks#create'
  delete 'logout', to: 'tasks#destroy'

  get 'signup', to:'tasks#new'  
  resources :users, only: [:index, :show, :new, :create]
end
