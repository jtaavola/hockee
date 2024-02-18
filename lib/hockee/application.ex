defmodule Hockee.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      HockeeWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:hockee, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Hockee.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Hockee.Finch},
      # Start a worker by calling: Hockee.Worker.start_link(arg)
      # {Hockee.Worker, arg},
      # Start to serve requests, typically the last entry
      HockeeWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Hockee.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    HockeeWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
