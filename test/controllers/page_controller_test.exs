defmodule NGEOBackend.AuthPageControllerTest do
  use NGEOBackend.ConnCase

  # test "GET /", %{conn: conn} do
  #   conn = get conn, "/"
  #   assert html_response(conn, 200) =~ "#root"
  # end

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "GEO Monitor"
  end

  test "GET /users", %{conn: conn} do
    conn = get conn, "/users"
    assert html_response(conn, 200) =~ "Users"
  end

  test "GET /events", %{conn: conn} do
    conn = get conn, "/events"
    assert html_response(conn, 200) =~ "Events"
  end

end
