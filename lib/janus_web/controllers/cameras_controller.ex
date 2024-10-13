defmodule JanusWeb.CamerasController do
  @moduledoc """
  Documentation for JanusWeb.CamerasController.
  """
  use JanusWeb, :controller

  alias Janus.Account

  def index(conn, params) do
    conn
    |> put_view(JanusWeb.UserJson)
    |> render(:index, users: Account.list_user_with_cameras(params))
  end

  def notify_users(conn, _params) do
    Account.send_notify_user()

    json(conn, "emails have been sent.")
  end
end
