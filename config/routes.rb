RailsGame::Application.routes.draw do


  root :to => "Games#index"
  resources :games
  resources :users
  resource :sessions
  resources :profiles
  resources :tournaments
  resources :matches
  
  devise_scope :user do
    get 'signup', :to => 'devise/registrations#new'
    get 'login', :to => 'devise/sessions#new'
    get 'logout', :to => 'devise/sessions#destroy'
    delete 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session_path
  end


  match 'tournaments/:id/register' => 'tournaments#register', as: :tournaments_register
  match 'tournaments/:id/register_match/:id' => 'tournaments#register_match', as: :tournaments_register_match

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  
end
