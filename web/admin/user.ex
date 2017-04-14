defmodule NGEOBackend.ExAdmin.User do
  use ExAdmin.Register

  register_resource NGEOBackend.User do
    update_changeset :changeset_update
    create_changeset :changeset_create
  end
end
