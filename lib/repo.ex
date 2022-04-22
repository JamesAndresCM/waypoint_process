defmodule WaypointsProcessApi.Repo do
  use Ecto.Repo, otp_app: :waypoints_process_api, adapter: Ecto.Adapters.Postgres
  use Scrivener, page_size: 10
end
