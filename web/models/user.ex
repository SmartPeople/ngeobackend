defmodule NGEOBackend.User do
  require Logger
  use NGEOBackend.Web, :model
  use Ecto.Schema
  import Ecto.Changeset
  import Doorman.Auth.Bcrypt, only: [hash_password: 1]

  schema "users" do
    field :email, :string
    field :hashed_password, :string
    field :password, :string, virtual: true

    timestamps()

    has_many :events, NGEOBackend.Event
  end

  def changeset(user, params \\ %{}) do
    user
    |> cast(params, [:email, :password])
    |> validate_required([:email, :password])
    |> cast(params, ~w(email password))
    |> hash_password
  end

  def create_changeset(struct, params \\ %{}) do
    struct
    |> cast(params, ~w(email password))
    |> hash_password
  end

  def all do
    NGEOBackend.Repo.all(NGEOBackend.User)
  end

  def api_token(user) do 
    {:ok, inserted} = DateTime.from_naive(user.inserted_at, "Etc/UTC")
    timestamp       = to_string(DateTime.to_unix(inserted))
    %NGEOBackend.User{}
    |> cast(%{email: user.email, password: timestamp}, ~w(email password))
    |> hash_password
    |> Ecto.Changeset.get_change(:hashed_password)
  end
end