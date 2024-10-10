defmodule Janus.Repo.Migrations.AddUserToCameras do
  use Ecto.Migration

  def change do
    alter table(:cameras) do
      add :user_id, references(:users, on_delete: :delete_all)
    end
  end
end
