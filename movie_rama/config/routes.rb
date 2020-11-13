Rails.application.routes.draw do
  resources :movies
  resources :users, except: :new
  resources :sessions, only: %i[create]
  resources :movie_reactions, only: %i[create update destroy]

  get "/signup", to: "users#new"

  get "/login", to: "sessions#new"
  delete "/logout", to: "sessions#destroy"

  root to: "movies#index"
end
