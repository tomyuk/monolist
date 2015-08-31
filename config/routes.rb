Rails.application.routes.draw do

  unless Rails.enviroment == "production"
    mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  end
  root 'welcome#index'

  get 'ranking/have'
  get 'ranking/want'

  get 'signup', to: 'users#new'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :ownerships, only: [:create, :destroy]
  resources :items , only: [:new , :show]

  if Rails.env.development?
    get 'designs/index'
    get 'designs/user'
    get 'designs/item'
    get 'designs/sing_up'
    get 'designs/sign_in'
  end
end
