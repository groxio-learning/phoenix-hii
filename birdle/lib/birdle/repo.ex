defmodule Birdle.Repo do
  use Ecto.Repo,
    otp_app: :birdle,
    adapter: Ecto.Adapters.Postgres
end
