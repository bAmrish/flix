Rails.application.routes.draw do
  resources :genres
  root 'movies#index'

  get 'movies/filter/:filter' => 'movies#index', as: :filtered_movies
  resources :movies do 
    resources :favorites, only: [:create, :destroy]
    resources :reviews
  end

  resource 'session', only: [:new, :create, :destroy]
  resources :users

  get 'signup' => 'users#new'
  get 'login' => 'sessions#new'
  delete 'logout' => 'sessions#destroy'
end
