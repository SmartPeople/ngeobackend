defmodule NGEOBackend.ExAdmin.User do
  use ExAdmin.Register

  index do
    selectable_column()
    column :id
    column :name
    column "Created", fn(event) ->
      Phoenix.HTML.Tag.content_tag :span, event.inserted_at
    end
    column "Updated", fn(event) ->
      Phoenix.HTML.Tag.content_tag :span, event.updated_at
    end
    actions()
  end

  register_resource NGEOBackend.User do
  end
end
