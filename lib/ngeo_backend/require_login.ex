defmodule NGEOBackend.RequireLogin do
  import Plug.Conn
  require Logger

  def init(opts), do: opts

  def call(conn, _opts) do
    if Doorman.logged_in?(conn) do
      # Logger.debug(inspect(conn))
      # current_user = conn.assigns[:current_user]
      # Logger.debug(inspect(current_user))
      # token = Phoenix.Token.sign(conn, "user socket", current_user.id)
      # Logger.debug(inspect(token))
      # assign(conn, :user_token, token)
      conn
    else
      conn
      |> Phoenix.Controller.redirect(to: "/")
      |> halt
    end
  end
end
