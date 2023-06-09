Rails.application.routes.draw do
  # Resources
  resources "sessions"
  resources "users"
  
  # Login/out
  get "/login", :controller => "sessions", :action => "new"
  get "/logout", :controller => "sessions", :action => "destroy"

  # Define the root route
  get "/", :controller => "users", :action => "new"
end
