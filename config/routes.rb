Rails.application.routes.draw do
  resources :movies
  resources :users, except: :new
  resources :sessions, only: %i[new create destroy]
  resources :movie_reactions, only: %i[create update destroy]
  get '/signup', to: 'users#new'

  root to: 'movies#index'
end
