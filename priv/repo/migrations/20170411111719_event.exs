defmodule NGEOBackend.Repo.Migrations.Event do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :data, :map
      add :user_id, references(:users)
      timestamps()
    end
  end
end
