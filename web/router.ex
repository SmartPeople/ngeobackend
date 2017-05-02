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

  pipeline :admin do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Doorman.Login.Session
    plug NGEOBackend.RequireLogin
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", NGEOBackend do
    pipe_through :browser # Use the default browser stack

    get "/",        AuthPageController, :index
    get  "/logout", AuthPageController, :logoutAction
    post "/login",  AuthPageController, :loginAction
  end

  scope "/admin", ExAdmin do
    pipe_through :admin
    admin_routes()
  end
  
  scope "/api", NGEOBackend do
    pipe_through :api
    post "/login",  ApiController, :loginAction
  end
  
end
