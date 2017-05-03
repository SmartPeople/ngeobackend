defmodule NGEOBackend.PagesController do
  require Logger
  use NGEOBackend.Web, :controller

  def monitoring(conn, _params) do
    # Logger.debug(inspect(Doorman.logged_in?(conn)))
    render conn, "pages.html"
  end

end