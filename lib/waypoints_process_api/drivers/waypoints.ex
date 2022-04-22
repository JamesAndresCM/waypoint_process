defmodule WaypointsProcessApi.Drivers.Waypoints do
  import Ecto.Query, warn: false
  alias WaypointsProcessApi.Repo
  alias WaypointsProcessApi.Drivers.Waypoint
  import WaypointsProcessApi.Utils.ParseWaypointParams, only: [parse_params: 2]

  def all_elements(driver_id) do
    from(waypoint in Waypoint, where: waypoint.driver_id == ^driver_id, order_by: [asc: waypoint.created_at], preload: [:driver])
  end

  def get_driver_associated_waypoint_by_id(id) do
    Repo.preload(Repo.get!(Waypoint, id), :driver)
  end

  def get_driver_associated(%Waypoint{} = waypoint) do
    Repo.preload(waypoint, :driver)
  end

  def create_waypoint(attrs \\ %{}) do
    changeset = Waypoint.changeset(%Waypoint{}, parse_params("coordinates", attrs))
    Repo.insert(changeset)
  end
end
