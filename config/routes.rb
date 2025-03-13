Rails.application.routes.draw do
  root 'movies#index'

  resources :movies do 
    resources :reviews
  end

  resource 'session', only: [:new, :create, :delete]
  resources :users

  get 'signup' => 'users#new'
  get 'login' => 'sessions#new'
end
