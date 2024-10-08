defmodule Aurora.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Aurora.Repo,
      AuroraWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:aurora, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Aurora.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Aurora.Finch},
      # Start a worker by calling: Aurora.Worker.start_link(arg)
      # {Aurora.Worker, arg},
      # Start to serve requests, typically the last entry
      AuroraWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Aurora.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    AuroraWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
