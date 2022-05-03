defmodule WaypointsProcessApis.Repo do
  use Ecto.Repo,
    otp_app: :waypoints_process_api,
    adapter: Ecto.Adapters.Postgres
end
