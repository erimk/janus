defmodule Janus.Account.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :actived, :boolean, default: false
    field :deactivated_at, :utc_datetime
    field :email, :string
    field :name, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :actived, :deactivated_at])
    |> validate_required([:name, :email, :actived, :deactivated_at])
    |> unique_constraint(:email)
  end
end
