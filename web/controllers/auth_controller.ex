defmodule NGEOBackend.AuthPageController do
  require Logger
  use NGEOBackend.Web, :controller
  import Doorman.Login.Session

  def index(conn, _params) do
    Logger.debug(inspect(Doorman.logged_in?(conn)))
    render conn, "index.html", txt: inspect(get_current_user(conn))
  end

  def loginAction(conn, %{"name" => name, "password" => password}) do
    if user = Doorman.authenticate(name, password) do
      conn
      |> login(user)
      |> put_flash(:notice, "Successfully logged in")
      |> redirect(to: "/admin")
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
