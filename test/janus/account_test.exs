defmodule Janus.AccountTest do
  use Janus.DataCase

  import Janus.Factory

  alias Janus.Account
  alias Janus.Account.User

  describe "users" do
    @invalid_attrs %{actived: nil, deactivated_at: nil, email: nil, name: nil}

    test "list_users/0 returns all users" do
      user = insert(:user)
      assert Account.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = insert(:user)
      assert Account.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{actived: true, deactivated_at: ~U[2024-10-08 09:46:00Z], email: "some email", name: "some name"}

      assert {:ok, %User{} = user} = Account.create_user(valid_attrs)
      assert user.actived == true
      assert user.deactivated_at == ~U[2024-10-08 09:46:00Z]
      assert user.email == "some email"
      assert user.name == "some name"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Account.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = insert(:user)
      update_attrs = %{actived: false, deactivated_at: ~U[2024-10-09 09:46:00Z], email: "some updated email", name: "some updated name"}

      assert {:ok, %User{} = user} = Account.update_user(user, update_attrs)
      assert user.actived == false
      assert user.deactivated_at == ~U[2024-10-09 09:46:00Z]
      assert user.email == "some updated email"
      assert user.name == "some updated name"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = insert(:user)
      assert {:error, %Ecto.Changeset{}} = Account.update_user(user, @invalid_attrs)
      assert user == Account.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = insert(:user)
      assert {:ok, %User{}} = Account.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Account.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = insert(:user)
      assert %Ecto.Changeset{} = Account.change_user(user)
    end
  end
end
