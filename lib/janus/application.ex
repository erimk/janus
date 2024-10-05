defmodule Janus.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      JanusWeb.Telemetry,
      Janus.Repo,
      {DNSCluster, query: Application.get_env(:janus, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Janus.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Janus.Finch},
      # Start a worker by calling: Janus.Worker.start_link(arg)
      # {Janus.Worker, arg},
      # Start to serve requests, typically the last entry
      JanusWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Janus.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    JanusWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
