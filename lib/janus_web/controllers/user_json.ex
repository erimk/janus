defmodule JanusWeb.UserJson do
  @moduledoc """
  WIP
  """

  alias Janus.Account.User
  alias JanusWeb.CameraJson

  def index(%{users: users}) do
    %{data: %{users: for(user <- users, do: data(user))}}
  end

  def data(%User{} = user) do
    %{
      id: user.id,
      actived: user.actived,
      deactivated_at: user.deactivated_at,
      email: user.email,
      name: user.name,
      cameras: Enum.map(user.cameras, fn c -> CameraJson.data(c) end)
    }
  end
end
