defmodule Janus.SurveillanceTest do
  use Janus.DataCase

  import Janus.Factory

  alias Janus.Surveillance
  alias Janus.Surveillance.Camera

  describe "cameras" do
    @invalid_attrs %{actived: nil, brand: nil, name: nil}

    test "list_cameras_with_user/0 returns all cameras" do
      camera = insert(:camera)

      assert [subject] = Surveillance.list_cameras_with_user()

      assert subject.id == camera.id
      assert subject.user_id == camera.user_id
      assert subject.user.name == camera.user.name
    end

    test "get_camera!/1 returns the camera with given id" do
      camera = insert(:camera)

      assert subject = Surveillance.get_camera!(camera.id)
      assert subject.brand == camera.brand
      assert subject.user_id == camera.user_id
    end

    test "get_camera!/1 returns the camera with given camera name" do
      camera = insert(:camera)
      assert cam = Surveillance.get_camera_by_name!(camera.name)
      assert cam.name == camera.name
    end

    test "create_camera/1 with valid data creates a camera" do
      valid_attrs = %{actived: true, brand: "Intelbras", name: "some name"}

      assert {:ok, %Camera{} = camera} = Surveillance.create_camera(valid_attrs)
      assert camera.actived == true
      assert camera.brand == "Intelbras"
      assert camera.name == "some name"
    end

    test "create_camera/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Surveillance.create_camera(@invalid_attrs)
    end

    test "update_camera/2 with valid data updates the camera" do
      camera = insert(:camera)
      update_attrs = %{actived: false, brand: "Hikvision", name: "some updated name"}

      assert {:ok, %Camera{} = camera} = Surveillance.update_camera(camera, update_attrs)
      assert camera.actived == false
      assert camera.brand == "Hikvision"
      assert camera.name == "some updated name"
    end

    test "update_camera/2 with invalid data returns error changeset" do
      camera = insert(:camera)
      assert {:error, %Ecto.Changeset{}} = Surveillance.update_camera(camera, @invalid_attrs)
    end

    test "delete_camera/1 deletes the camera" do
      camera = insert(:camera)
      assert {:ok, %Camera{}} = Surveillance.delete_camera(camera)
      assert_raise Ecto.NoResultsError, fn -> Surveillance.get_camera!(camera.id) end
    end

    test "change_camera/1 returns a camera changeset" do
      camera = insert(:camera)
      assert %Ecto.Changeset{} = Surveillance.change_camera(camera)
    end
  end
end
