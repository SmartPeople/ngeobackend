defmodule NGEOBackend.ExAdmin.Dashboard do
  use ExAdmin.Register

  register_page "Dashboard" do
    menu priority: 1, label: "Dashboard"
    content do
      div id: "root"
      script src: "/js/app.js"
    end
  end
end
