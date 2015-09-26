Rails.application.routes.draw do

  #resources :user_sessions
  resources :users

  get 'login' => 'user_sessions#new', :as => :get_login
  post 'login' => 'user_sessions#create', :as => :login
  post 'logout' => 'user_sessions#destroy', :as => :logout

  resources :auctions, shallow: true do
    resources :bids
  end

  root to: 'welcome#welcome'
end
