defmodule Demo3.Repo do
  use Ecto.Repo,
    otp_app: :demo3,
    adapter: Ecto.Adapters.Postgres
end
