Bedazzle::Application.routes.draw do

  # devise_for :users
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  resources :twilios

  root to: "homes#index"
  # root to: "events#index"
  resources :events
  resources :players, :only => [:create]

  get "players" => 'players#index'
  match "twilios" => 'twilios#index'

  #for Facebook Login
  # match 'auth/facebook/callback', to: 'sessions#create'
  # match 'auth/failure', to: redirect('/')
  # match 'signout', to: 'sessions#destroy', as: 'signout'

end
