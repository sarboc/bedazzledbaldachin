Bedazzle::Application.routes.draw do

  devise_for :users
  # devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :send_texts
  resources :receive_texts

  root to: "events#index"
  resources :events
  resources :players, :only => [:create]

  get "send_texts" => 'send_texts#index'
  match "receive_texts" => 'receive_texts#index'

  #for Facebook Login
  match 'auth/:provider/callback', to: 'sessions#create'
  match 'auth/failure', to: redirect('/')
  match 'signout', to: 'sessions#destroy', as: 'signout'

end
