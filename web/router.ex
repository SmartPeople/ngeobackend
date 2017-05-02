defmodule NGEOBackend.Router do
  use NGEOBackend.Web, :router
  use ExAdmin.Router
  
  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Doorman.Login.Session
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", NGEOBackend do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    post "/login", PageController, :loginAction
  end

  scope "/admin", ExAdmin do
    pipe_through :browser
    admin_routes()
  end
  
  # Other scopes may use custom stacks.
  # scope "/api", NGEOBackend do
  #   pipe_through :api
  # end
end
