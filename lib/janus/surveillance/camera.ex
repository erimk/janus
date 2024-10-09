defmodule Janus.Surveillance.Camera do
  @moduledoc """
    WIP
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "cameras" do
    field :actived, :boolean, default: false
    field :brand, Ecto.Enum, values: [:Intelbras, :Hikvision, :Giga, :Vivotek]
    field :name, :string

    timestamps(type: :utc_datetime)
  end

  @required [:name, :actived, :brand]

  @doc false
  def changeset(camera, attrs) do
    camera
    |> cast(attrs, @required)
    |> validate_required(@required)
  end
end
