defmodule Birdle.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      BirdleWeb.Telemetry,
      Birdle.Repo,
      {DNSCluster, query: Application.get_env(:birdle, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Birdle.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Birdle.Finch},
      # Start a worker by calling: Birdle.Worker.start_link(arg)
      # {Birdle.Worker, arg},
      # Start to serve requests, typically the last entry
      BirdleWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Birdle.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    BirdleWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
