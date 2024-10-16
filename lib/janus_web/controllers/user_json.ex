defmodule JanusWeb.UserJson do
  @moduledoc """
    Formatter json for users data.
  """

  alias Janus.Account.User
  alias JanusWeb.CameraJson

  def index(%{users: users}) do
    %{data: %{users: for(user <- users, do: data(user))}}
  end

  def data(%User{} = user) do
    %{
      id: user.id,
      active: user.active,
      deactivated_at: user.deactivated_at,
      email: user.email,
      name: user.name,
      cameras: Enum.map(user.cameras, fn c -> CameraJson.data(c) end)
    }
  end
end
