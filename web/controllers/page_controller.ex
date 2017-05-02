defmodule NGEOBackend.PageController do
  require Logger
  use NGEOBackend.Web, :controller
  import Doorman.Login.Session, only: [login: 2]

  def index(conn, _params) do
    http2 =
      case conn.adapter do
        {_, %{version: :"HTTP/2"}} -> true
        _                          -> false
      end

    render conn, "index.html", http2: http2
  end

  def loginAction(conn, %{"name" => name, "password" => password}) do
    
    if user = Doorman.authenticate(name, password) do
      conn
      |> login(user) # Sets :user_id on conn's session
      |> put_flash(:notice, "Successfully logged in")
      |> redirect(to: "/admin")
    else
      conn
      |> put_flash(:error, "No user found with the provided credentials")
      |> render("index.html")
    end
  end

end
