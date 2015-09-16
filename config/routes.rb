RailsGame::Application.routes.draw do


  root :to => "Games#index"
  resources :games
  resources :users
  resource :sessions
  resources :profiles
  resources :tournaments
  resources :matches

  devise_for :user
  
  devise_scope :user do
    get 'signup', :to => 'devise/registrations#new'
    get 'login', :to => 'devise/sessions#new'
    get 'logout', :to => 'devise/sessions#destroy'
  end


  match 'tournaments/:id/register' => 'tournaments#register', as: :tournaments_register
  match 'tournaments/:id/register_match/:id' => 'tournaments#register_match', as: :tournaments_register_match

  match 'auth/:provider/callback', to: 'sessions#create'
  match 'auth/failure', to: redirect('/')

  
end
