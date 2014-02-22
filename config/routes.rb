Music::Application.routes.draw do

  resources :users
  resources :sessions

  resources :bands do
    resources :albums, :only => [:new, :create, :index] do
      resources :track, :only => [:new, :create, :index]
    end
  end

  resources :album, :only => [:show]
  resources :track, :only => [:show]

end
