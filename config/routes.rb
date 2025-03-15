Rails.application.routes.draw do
  root 'movies#index'

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
