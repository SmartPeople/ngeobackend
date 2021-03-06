defmodule NGEOBackend.AuthPageController do
  require Logger
  use NGEOBackend.Web, :controller
  import Doorman.Login.Session

  def index(conn, _params) do
    render conn, "index.html"
  end

  def loginAction(conn, %{"email" => email, "password" => password}) do
    if user = Doorman.authenticate(email, password) do
      conn
      |> login(user)
      |> put_flash(:notice, "Successfully logged in")
      |> redirect(to: "/")
    else
      conn
      |> put_flash(:error, "No user found with the provided credentials")
      |> render("index.html")
    end
  end

  def logoutAction(conn, _params) do 
    conn
    |> logout
    |> put_flash(:notice, "Successfully logged out")
    |> redirect(to: "/")
  end

end
