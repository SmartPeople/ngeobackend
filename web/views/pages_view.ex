defmodule NGEOBackend.PagesView do
  use NGEOBackend.Web, :view

  def filterOut(points) do
    Enum.filter(points, &(&1.data["type"] == 0))
  end

  def numberOfPoints(points) do
    Enum.count(points, &(&1.data["type"] == 0))
  end

  def numberOfEvents(points) do
    Enum.count(points)
  end

  def allUsers do
    Enum.map(NGEOBackend.User.all(), fn(u) -> {u.email, u.id} end)
  end

end