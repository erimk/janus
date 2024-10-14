defmodule Janus.Account do
  @moduledoc """
  The Account context.
  """

  import Ecto.Query, warn: false

  alias Janus.Account.User
  alias Janus.Mailer
  alias Janus.Repo
  alias Janus.Surveillance

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc "Returns the list of user with cameras"
  @spec list_user_with_cameras(map()) :: list()
  def list_user_with_cameras(params) do
    User
    |> preload(cameras: ^Surveillance.preload_camera_query(params))
    |> Repo.all()
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end

  def get_hikvision_users do
    User
    |> preload(cameras: ^Surveillance.preload_hikvision_query())
    |> where([u], u.active == true)
    |> Repo.all()
  end

  def send_notify_user do
    users = get_hikvision_users()

    Enum.each(users, fn user -> user |> Mailer.create_notify_user() |> Mailer.deliver() end)
  end
end
