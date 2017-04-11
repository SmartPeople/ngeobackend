defmodule NGEOBackend.Repo.Migrations.Users do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :password, :string
    end
  end
end
