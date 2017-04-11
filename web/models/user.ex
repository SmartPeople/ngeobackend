defmodule User do
  use Ecto.Schema

  import Ecto.Changeset

  schema "users" do
    field :name
    field :password
  end

  def changeset(user, params \\ %{}) do
    user
    |> cast(params, [:name, :passwaord])
    |> validate_required([:name, :passwaord])
  end
end