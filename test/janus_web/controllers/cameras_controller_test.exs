defmodule JanusWeb.CamerasControllerTest do
  use JanusWeb.ConnCase, async: true

  import Janus.Factory
  import Swoosh.TestAssertions

  describe "index" do
    test "returns a list of cameras group by user when no filter" do
      user = insert(:user)
      insert_list(3, :camera, %{user: user})

      conn =
        build_conn()
        |> get("/api/cameras")

      assert [subject] = json_response(conn, 200)["data"]["users"]
      assert subject["id"] == user.id
      assert subject["name"] == user.name
      assert subject["active"] == true
      assert subject["deactivated_at"] == nil

      assert x_cameras = subject["cameras"]
      assert length(x_cameras) == 3
      assert %{"name" => _, "brand" => _, "active" => _} = List.first(x_cameras)
    end
  end

  test "returns a list of cameras group by user when filter by camera's name" do
    user = insert(:user)
    insert_list(3, :camera, %{user: user})
    camera_a = insert(:camera, %{name: "procurada", user: user})
    camera_b = insert(:camera, %{name: "procam", user: user})

    conn =
      build_conn()
      |> get("/api/cameras?name=pro")

    assert [exp_user] = json_response(conn, 200)["data"]["users"]
    assert [subject_a, subject_b] = exp_user["cameras"]
    assert subject_a["name"] == camera_b.name
    assert subject_b["name"] == camera_a.name
  end

  test "returns no camera when user and camera deactivated" do
    user = insert(:user, %{deactivated_at: ~U[2024-10-13 01:38:30Z]})
    insert(:camera, %{user: user, active: false})

    conn =
      build_conn()
      |> get("/api/cameras")

    assert [subject] = json_response(conn, 200)["data"]["users"]
    assert subject["cameras"] == []
  end

  describe "notify_users" do
    test "returns ok when send email to Hikvision's users" do
      camera = insert(:camera, %{brand: "Hikvision"})
      cam2 = insert(:camera, %{brand: "Giga"})
      other_user = cam2.user.name
      other_email = cam2.user.email

      conn =
        build_conn()
        |> post("/api/notify-users")

      assert json_response(conn, 200)
      assert_email_sent(Janus.Mailer.create_notify_user(camera.user))
      refute_email_sent(name: ^other_user, address: ^other_email)
    end
  end
end
