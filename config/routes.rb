Rails.application.routes.draw do
  resources :movies
  resources :users
  resources :sessions, only: %i[create destroy]
  resources :movie_reactions, only: %i[create update destroy]

  root to: 'movies#index'
end
