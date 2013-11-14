Bedazzle::Application.routes.draw do

  # devise_for :users
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :send_texts
  resources :twilios

  root to: "events#index"
  resources :events
  resources :players, :only => [:create]

  get "send_texts" => 'twilios_texts#index'
  match "twilios" => 'twilios_texts#index'

  #for Facebook Login
  # match 'auth/:provider/callback', to: 'sessions#create'
  # match 'auth/failure', to: redirect('/')
  # match 'signout', to: 'sessions#destroy', as: 'signout'

end
