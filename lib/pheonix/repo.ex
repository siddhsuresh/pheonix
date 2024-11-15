defmodule Pheonix.Repo do
  use Ecto.Repo,
    otp_app: :pheonix,
    adapter: Ecto.Adapters.Postgres
end
