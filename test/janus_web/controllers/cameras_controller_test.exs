defmodule JanusWeb.CamerasControllerTest do
  use JanusWeb.ConnCase, async: true

  import Janus.Factory

  describe "index" do
    test "returns a list of cameras by user when valid data" do
      user = insert(:user)
      insert_list(3, :camera, %{user: user})

      conn =
        build_conn()
        |> get("/api/cameras")

      assert [subject] = json_response(conn, 200)["data"]["users"]
      assert subject["id"] == user.id
      assert subject["name"] == user.name
      assert subject["actived"] == true
      assert subject["deactivated_at"] == nil

      assert x_cameras = subject["cameras"]
      assert length(x_cameras) == 3
      assert %{"name" => _, "brand" => _, "actived" => _} = List.first(x_cameras)
    end
  end

  # test "returns a list of cameras when filter by camera's name" do

  # end

  # test "returns no camera when user and camera deactivated" do

  # end
end
