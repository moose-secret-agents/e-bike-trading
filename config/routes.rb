Rails.application.routes.draw do

  #resources :user_sessions
  resources :users

  get 'login' => 'user_sessions#new', :as => :get_login
  post 'login' => 'user_sessions#create', :as => :login
  post 'logout' => 'user_sessions#destroy', :as => :logout

  resources :auctions, shallow: true do
    get 'tweet', on: :member, to: 'auctions#tweet', as: 'tweet'
    post 'delete_images', on: :member, to: 'auctions#delete_images', as: 'delete_images'
    resources :bids
  end

  root to: 'welcome#welcome'
end
