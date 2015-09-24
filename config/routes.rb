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

  namespace :admin do
    get '', to: 'dashboard#index', as: '/'
    match 'search', to: 'search#index', as: :search
  end

  devise_scope :user do
    get 'signup', :to => 'devise/registrations#new'
    get 'login', :to => 'devise/sessions#new'
    get 'logout', :to => 'devise/sessions#destroy'
    delete 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session_path
  end

  match 'tournaments_list' => 'tournaments#list', as: :tournaments_list
  match 'tournaments_map' => 'tournaments#map', as: :tournaments_map
  match 'tournaments_map_show' => 'tournaments#map_show', as: :tournaments_map_show
  match 'tournaments/:id/register' => 'tournaments#register', as: :tournaments_register
  match 'tournaments/:id/register_match/:id' => 'tournaments#register_match', as: :tournaments_register_match
  match 'matches/:id/unregister_match' => 'matches#unregister_match', as: :matches_unregister_match

  match 'games/:id/change_grade' => 'games#change_grade', as: :games_change_grade

  devise_for :user, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", registrations: "registrations" }

  
end
