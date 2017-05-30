defmodule NGEOBackend.PagesController do
  require Logger
  use NGEOBackend.Web, :controller

  def monitoring(conn, _params) do
    # Logger.debug(inspect(Doorman.logged_in?(conn)))
    render conn, "pages.html"
  end

  def grouped_points(conn, _params) do
    conn
    |> assign(:points, NGEOBackend.Event.allPositions())
    |> render("grouped_points.html")
  end
  
  def heatmap_points(conn, _params) do
    conn
    |> assign(:points, NGEOBackend.Event.allPositions())
    |> render("heatmap_points.html")
  end

end