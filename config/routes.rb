Rails.application.routes.draw do

  resources :auctions, shallow: true do
    resources :bids
  end

  root to: 'welcome#welcome'
end
