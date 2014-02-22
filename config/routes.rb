Music::Application.routes.draw do

  resources :users
  resources :sessions

  resources :bands do
    resources :albums, :only => [:new, :create, :index] do
      resources :tracks, :only => [:new, :create, :index]
    end
  end

  resources :albums, :only => [:show, :destroy]
  resources :tracks, :only => [:show, :destroy]

end
