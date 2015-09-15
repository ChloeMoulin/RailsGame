RailsGame::Application.routes.draw do

  root :to => "Games#index"
  resources :games
  resources :users
  resource :session
  resources :profiles
  resources :tournaments
  resources :matches

  match '/login' => "sessions#new", :as => "login"
  match '/logout' => "sessions#destroy", :as => "logout"

  match 'tournaments/:id/register' => 'tournaments#register', as: :tournaments_register
  match 'tournaments/:id/register_match/:id' => 'tournaments#register_match', as: :tournaments_register_match

  match 'auth/:provider', to: 'sessions#create'
  match 'auth/failure', to: redirect('/')

  
end
