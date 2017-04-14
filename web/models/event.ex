defmodule NGEOBackend.Event do
  use Ecto.Schema

  import Ecto.Changeset

  schema "events" do
    field :data, :map, default: %{}
    timestamps()
    belongs_to :user, NGEOBackend.User
  end

  def changeset(data, params \\ %{}) do
    data
    |> cast(params, [:data])
    |> validate_required([:data])
  end

end