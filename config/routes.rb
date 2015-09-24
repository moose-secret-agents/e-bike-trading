Rails.application.routes.draw do

  resources :auctions
  root to: 'welcome#welcome'

end
