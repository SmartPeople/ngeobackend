defmodule NGEOBackend.PagesView do
  use NGEOBackend.Web, :view

  def filterOut(points) do
    Enum.filter(points, &(&1.data["type"] == 0))
  end

end