defmodule Janus.Surveillance.Camera do
  @moduledoc """
    WIP
  """

  use Ecto.Schema

  import Ecto.Changeset

  alias Janus.Account.User

  schema "cameras" do
    field :active, :boolean, default: true
    field :brand, :string
    field :name, :string

    belongs_to :user, User

    timestamps(type: :utc_datetime)
  end

  @required [:name, :active, :brand]

  @doc false
  def changeset(camera, attrs) do
    camera
    |> cast(attrs, @required)
    |> validate_required(@required)
  end
end
