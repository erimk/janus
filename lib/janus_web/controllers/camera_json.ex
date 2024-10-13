defmodule JanusWeb.CameraJson do
  @moduledoc """
   Formatter json for cameras data.
  """

  alias Janus.Surveillance.Camera

  def data(%Camera{} = camera) do
    %{
      id: camera.id,
      active: camera.active,
      brand: camera.brand,
      name: camera.name
    }
  end
end
