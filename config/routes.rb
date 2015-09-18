RailsGame::Application.routes.draw do


  resources :locations


  root :to => "Games#index"
  resources :games
  resources :users do
    member do 
      post :inscription
    end
  end
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
  match 'matches/:id/unregister_match' => 'matches#unregister_match', as: :matches_unregister_match

  devise_for :user, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", registrations: "registrations" }

  
end
