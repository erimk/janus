defmodule Janus.Factory do
  @moduledoc false

  use ExMachina.Ecto, repo: Janus.Repo

  def user_factory do
    %Janus.Account.User{
      name: sequence(:name, &"João-#{&1}"),
      email: sequence(:email, &"algo_#{&1}@mail.com")
    }
  end
end
