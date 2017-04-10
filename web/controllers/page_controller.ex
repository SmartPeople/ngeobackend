defmodule NGEOBackend.PageController do
  use NGEOBackend.Web, :controller

  def index(conn, _params) do
    http2 =
      case conn.adapter do
        {_, %{version: :"HTTP/2"}} -> true
        _                          -> false
      end

    render conn, "index.html", http2: http2
  end
end
