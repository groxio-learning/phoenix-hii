defmodule Bigr.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Bigr.Server, :cats},
      {Bigr.Server, :dogs},
      {Bigr.Server, :alligator},
      {Bigr.Server, :poodle}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :rest_for_one, name: :sup]
    Supervisor.start_link(children, opts)
  end
end
