defmodule Janus.Repo.Migrations.CreateCameras do
  use Ecto.Migration

  def change do
    create table(:cameras) do
      add :name, :string
      add :active, :boolean, default: false, null: false
      add :brand, :string

      timestamps(type: :utc_datetime)
    end
  end
end
