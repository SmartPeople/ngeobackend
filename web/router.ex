defmodule NGEOBackend.Router do
  require Logger
  use NGEOBackend.Web, :router
  use ExAdmin.Router
  
  pipeline :public do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Doorman.Login.Session
    plug :put_user_token
  end

  pipeline :private do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Doorman.Login.Session
    plug NGEOBackend.RequireLogin
    plug :put_user_token
  end

  defp put_user_token(conn, _) do
    if current_user = conn.assigns[:current_user] do
      token = Phoenix.Token.sign(conn, "user socket", current_user.id)
      assign(conn, :user_token, token)
    else
      conn
    end
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", NGEOBackend do
    pipe_through :public # Use the default public stack

    get "/login",  AuthPageController, :index
    get "/logout", AuthPageController, :logoutAction
    post "/login", AuthPageController, :loginAction
  end

  scope "/", NGEOBackend do
    pipe_through :private # Use the default public stack
    get "/",           PagesController, :monitoring
    get "/monitoring", PagesController, :monitoring
    get "/grouped",    PagesController, :grouped_points
  end

  scope "/admin", ExAdmin do
    pipe_through :private
    admin_routes()
  end
  
  scope "/api", NGEOBackend do
    pipe_through :api
    post "/login",  ApiController, :loginAction
  end
  
end
