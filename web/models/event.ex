defmodule NGEOBackend.Event do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, only: [from: 2]
  require Ecto.Query
  require Logger

  schema "events" do
    field :data, :map, default: %{}
    field :uuid, :string
    timestamps()
    belongs_to :user, NGEOBackend.User
  end

  def changeset(data, params \\ %{}) do
    data
    |> cast(params, [:data, :uuid])
    |> validate_required([:data, :uuid])
  end

  def insert(name, data) do
    user = NGEOBackend.User 
    |> NGEOBackend.Repo.get_by(email: name)
    
    %NGEOBackend.Event{user: user, data: data, uuid: data["uuidV4Tracking"]} 
    |> NGEOBackend.Repo.insert
  end

    def all do
      NGEOBackend.Repo.all(NGEOBackend.Event)
    end

    def allEvents do
      query = 
        from e in NGEOBackend.Event, 
        order_by: e.inserted_at
      NGEOBackend.Repo.all(query)
    end

    def allPositions do
      query = 
        from e in NGEOBackend.Event, 
        order_by: e.inserted_at
      NGEOBackend.Repo.all(query)
    end

end