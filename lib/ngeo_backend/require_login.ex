defmodule NGEOBackend.RequireLogin do
  import Plug.Conn
  require Logger

  def init(opts), do: opts

  def call(conn, _opts) do
    if Doorman.logged_in?(conn) do
      conn
    else
      conn
      |> Phoenix.Controller.redirect(to: "/login")
      |> halt
    end
  end
end
