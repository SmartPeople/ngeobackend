defmodule NGEOBackend.ExAdmin.Dashboard do
  use ExAdmin.Register
  require Logger

  register_page "Dashboard" do
    menu priority: 1, label: "Dashboard"
    content do
      h1 "Dashboard"
    end
  end
end
