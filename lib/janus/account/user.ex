defmodule Janus.Account.User do
  @moduledoc """
    WIP
  """
  use Ecto.Schema

  import Ecto.Changeset

  alias Janus.Surveillance.Camera

  schema "users" do
    field :actived, :boolean, default: true
    field :deactivated_at, :utc_datetime
    field :email, :string
    field :name, :string

    has_many :cameras, Camera

    timestamps(type: :utc_datetime)
  end

  @required [:name, :email, :actived]
  @optional [:deactivated_at]

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @required ++ @optional)
    |> validate_required(@required)
    |> unique_constraint(:email)
  end
end
