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

  def heatmap_points(conn, %{"filter" => %{"dt_start" => dt_start, "dt_end" => dt_end, "user_id" => user_id}}) do
    start_dt = 
      NaiveDateTime.from_erl!({
        {
          String.to_integer(dt_start["year"]), 
          String.to_integer(dt_start["month"]),
          String.to_integer(dt_start["day"])
        }, 
        {00, 00, 00}
      });

    end_dt   = 
      NaiveDateTime.from_erl!({
        {
          String.to_integer(dt_end["year"]), 
          String.to_integer(dt_end["month"]),
          String.to_integer(dt_end["day"])
        }, 
        {00, 00, 00}
      });
    conn
    |> assign(:points, NGEOBackend.Event.filteredPositions(start_dt, end_dt, user_id))
    |> render("heatmap_points.html")
  end

  def heatmap_points(conn, _params) do
    conn
    |> assign(:points, NGEOBackend.Event.allPositions())
    |> render("heatmap_points.html")
  end

end