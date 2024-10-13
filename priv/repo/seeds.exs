# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Janus.Repo.insert!(%Janus.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

defmodule Seeds do
  alias Janus.Account.User
  alias Janus.Surveillance.Camera
  alias Janus.Repo

  @brands ["Intelbras", "Hikvision", "Giga", "Vivotek"]

  def unique, do: System.unique_integer([:positive])

  def insert_active_user do
    unique = unique()

    Repo.insert!(%User{
      active: true,
      deactivated_at: nil,
      email: "fulano_#{unique}@mail.com",
      name: "Fulano #{unique}"
    })
  end

  def insert_inactive_user do
    unique = unique()

    Repo.insert!(%User{
      active: false,
      deactivated_at: ~U[2024-10-13 17:20:11Z],
      email: "fulano_#{unique}@mail.com",
      name: "Fulano #{unique}"
    })
  end

  def insert_camera(user_id) do
    Repo.insert!(%Camera{
      active: Enum.random([true, false]),
      brand: Enum.random(@brands),
      name: "Camera ##{unique()}",
      user_id: user_id
    })
  end

  def insert_inactive_camera(user_id) do
    Repo.insert!(%Camera{
      active: false,
      brand: Enum.random(@brands),
      name: "Camera ##{unique()}",
      user_id: user_id
    })
  end
end

Enum.each(1..999, fn _ ->
  user = Seeds.insert_active_user()

  Task.async(fn ->
    Enum.each(1..50, fn _ -> Seeds.insert_camera(user.id) end)
  end)
end)

user = Seeds.insert_inactive_user()
Enum.each(1..50, fn _ -> Seeds.insert_inactive_camera(user.id) end)
