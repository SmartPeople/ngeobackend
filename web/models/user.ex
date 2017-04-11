defmodule User do
  use Ecto.Schema

  import Ecto.Changeset

  schema "users" do
    field :name
    field :password
    timestamps()
    has_many :events, NGEOBackend.Event
  end

  def changeset(user, params \\ %{}) do
    user
    |> cast(params, [:name, :password])
    |> validate_required([:name, :password])
  end
end