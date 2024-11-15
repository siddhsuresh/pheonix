defmodule Pheonix.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PheonixWeb.Telemetry,
      Pheonix.Repo,
      {DNSCluster, query: Application.get_env(:pheonix, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Pheonix.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Pheonix.Finch},
      # Start a worker by calling: Pheonix.Worker.start_link(arg)
      # {Pheonix.Worker, arg},
      # Start to serve requests, typically the last entry
      PheonixWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Pheonix.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PheonixWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
