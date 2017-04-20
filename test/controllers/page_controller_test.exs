defmodule NGEOBackend.PageControllerTest do
  use NGEOBackend.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "NGEO Backend!"
  end

  test "GET /admin", %{conn: conn} do
    conn = get conn, "/admin"
    assert html_response(conn, 200) =~ "Welcome to ExAdmin"
  end

  test "GET /admin/users", %{conn: conn} do
    conn = get conn, "/admin/users"
    assert html_response(conn, 200) =~ "Users"
  end

  test "GET /admin/events", %{conn: conn} do
    conn = get conn, "/admin/events"
    assert html_response(conn, 200) =~ "Events"
  end

end
