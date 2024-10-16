defmodule Janus.Surveillance do
  @moduledoc """
  The Surveillance context.
  """

  import Ecto.Query, warn: false
  alias Janus.Repo

  alias Janus.Surveillance.Camera

  @doc """
  Returns the list of cameras.

  ## Examples

      iex> list_cameras()
      [%Camera{}, ...]

  """
  def list_cameras do
    Repo.all(Camera)
  end

  @doc """
  Gets a single camera.

  Raises `Ecto.NoResultsError` if the Camera does not exist.

  ## Examples

      iex> get_camera!(123)
      %Camera{}

      iex> get_camera!(456)
      ** (Ecto.NoResultsError)

  """
  def get_camera!(id), do: Repo.get!(Camera, id)

  @doc """
  Gets a single camera.

  Raises `Ecto.NoResultsError` if the Camera does not exist.

  ## Examples

      iex> get_camera!(123)
      %Camera{}

      iex> get_camera!(456)
      ** (Ecto.NoResultsError)

  """
  def get_camera_by_name!(name), do: Repo.get_by!(Camera, name: name)

  @doc """
  Creates a camera.

  ## Examples

      iex> create_camera(%{field: value})
      {:ok, %Camera{}}

      iex> create_camera(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_camera(attrs \\ %{}) do
    %Camera{}
    |> Camera.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a camera.

  ## Examples

      iex> update_camera(camera, %{field: new_value})
      {:ok, %Camera{}}

      iex> update_camera(camera, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_camera(%Camera{} = camera, attrs) do
    camera
    |> Camera.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a camera.

  ## Examples

      iex> delete_camera(camera)
      {:ok, %Camera{}}

      iex> delete_camera(camera)
      {:error, %Ecto.Changeset{}}

  """
  def delete_camera(%Camera{} = camera) do
    Repo.delete(camera)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking camera changes.

  ## Examples

      iex> change_camera(camera)
      %Ecto.Changeset{data: %Camera{}}

  """
  def change_camera(%Camera{} = camera, attrs \\ %{}) do
    Camera.changeset(camera, attrs)
  end

  @doc "Returns a query for preload cameras based on params."
  @spec preload_camera_query(map()) :: Ecto.Query.t()
  def preload_camera_query(params) do
    Camera
    |> where([c], c.active == true)
    |> where(^filter_by_name(params["name"]))
    |> order_by([c], asc: :name)
  end

  defp filter_by_name(nil), do: true
  defp filter_by_name(name), do: dynamic([c], ilike(c.name, ^"#{name}%"))

  @doc "Returns a query for preload Hikvision's cameras."
  @spec preload_hikvision_query :: Ecto.Query.t()
  def preload_hikvision_query do
    Camera
    |> where([c], c.brand == "Hikvision")
  end
end
