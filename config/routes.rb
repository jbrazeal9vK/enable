Rails.application.routes.draw do
  # Resources
  resources "sessions"
  # resources "users"
  resources :users do
    collection { get :export }
  end

  # Login/out
  get "/login", :controller => "sessions", :action => "new"
  get "/logout", :controller => "sessions", :action => "destroy"

  # Define the root route
  get "/", :controller => "services", :action => "index"


end
