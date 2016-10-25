Rails.application.routes.draw do


  devise_for :users
  resources :conversations
  root to: "home#index"
  get "/privacy", to: "home#privacy"
  match "/webhook", to: "bot#webhook", via: [:get, :post]
  match '/images/:image', to: "your#showpic", via: "get", as: :renderpic
end
