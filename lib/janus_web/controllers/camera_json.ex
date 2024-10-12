defmodule JanusWeb.CameraJson do
  @moduledoc """
  WIP
  """

  alias Janus.Surveillance.Camera

  def data(%Camera{} = camera) do
    %{
      id: camera.id,
      actived: camera.actived,
      brand: camera.brand,
      name: camera.name
    }
  end
end
