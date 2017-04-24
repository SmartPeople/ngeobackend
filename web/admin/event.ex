defmodule NGEOBackend.ExAdmin.Event do
  use ExAdmin.Register
  require Logger

  register_resource NGEOBackend.Event do

    index do
      selectable_column()
      column :id
      column :uuid
      column "Type", fn(event) -> 
        # Logger.debug(inspect(event))
        Phoenix.HTML.Tag.content_tag :span, event.data["type"]
      end
      column "Created", fn(event) ->
        Phoenix.HTML.Tag.content_tag :span, event.inserted_at
      end
      column "Updated", fn(event) ->
        Phoenix.HTML.Tag.content_tag :span, event.updated_at
      end
      actions()
    end

    form event do
      inputs do
        input event, :uuid
        input event, :user, collection: NGEOBackend.User.all
      end

    end

  end
end
