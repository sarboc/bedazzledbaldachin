Bedazzle::Application.routes.draw do

  devise_for :users
  resources :send_texts
  resources :receive_texts

  get "events/index"

root to: "events#index"

  get "send_texts" => 'send_texts#index'
  match "receive_texts" => 'receive_texts#index'

end
