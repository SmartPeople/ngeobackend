defmodule NGEOBackend.Search do
  use Ecto.Schema
  import Ecto.Changeset
  require Logger

  schema "search" do
    field :dt_start, :map
    field :dt_end,   :map
    field :user_id,  :integer
  end

  def checkInteger(i) do
    case Integer.parse(i) do
      {r, _} -> []
      :error -> [{:dt_start, "Wrong date format!"}]
    end
  end

  def checkDt(fieldAtom, dt, key) do
    case dt do
      %{^key  => y} -> checkInteger(y)
      _ -> [{fieldAtom, "Wrong date format!"}]
    end
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:dt_start, :dt_end, :user_id])
    |> validate_required([:dt_start, :dt_end, :user_id])
    |> validate_change(:dt_start, fn _, dt_start -> checkDt(:dt_start, dt_start, "year") end )
    |> validate_change(:dt_start, fn _, dt_start -> checkDt(:dt_start, dt_start, "month") end )
    |> validate_change(:dt_start, fn _, dt_start -> checkDt(:dt_start, dt_start, "day") end )
    |> validate_change(:dt_end, fn _, dt_end -> checkDt(:dt_end, dt_end, "year") end )
    |> validate_change(:dt_end, fn _, dt_end -> checkDt(:dt_end, dt_end, "month") end )
    |> validate_change(:dt_end, fn _, dt_end -> checkDt(:dt_end, dt_end, "day") end )
  end

end