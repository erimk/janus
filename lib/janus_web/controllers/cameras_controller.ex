defmodule JanusWeb.CamerasController do
  @moduledoc """
  Documentation for JanusWeb.CamerasController.
  """
  alias Janus.Account
  use JanusWeb, :controller

  def index(conn, params) do
    conn
    |> put_view(JanusWeb.UserJson)
    |> render(:index, users: Account.list_user_with_cameras(params))
  end
end
