defmodule NGEOBackend.ApiController do
  require Logger
  use NGEOBackend.Web, :controller
  import Doorman.Login.Session

  def loginAction(conn, %{"email" => email, "password" => password}) do
    if user = Doorman.authenticate(email, password) do
      {:ok, updated}  = DateTime.from_naive(user.updated_at, "Etc/UTC")
      {:ok, inserted} = DateTime.from_naive(user.inserted_at, "Etc/UTC")

      conn
      |> json %{
            id: user.id, 
            user: user.email, 
            updated: DateTime.to_unix(updated),
            inserted: DateTime.to_unix(inserted),
            token: NGEOBackend.User.api_token(user)
          }
    else
      conn
      |> json %{login: false}
    end
  end

end
