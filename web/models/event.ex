defmodule Event do
  use Ecto.Schema

#   import Ecto.Changeset

  schema "events" do
    field :data, :map, default: %{}
    timestamps()
    belongs_to :user, NGEOBackend.User
  end

end