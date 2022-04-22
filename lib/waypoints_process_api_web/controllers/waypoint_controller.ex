defmodule WaypointsProcessApiWeb.WaypointController do
  use WaypointsProcessApiWeb, :controller
  alias WaypointsProcessApi.Repo
  alias WaypointsProcessApi.Drivers.Waypoints
  action_fallback WaypointsProccessApiWeb.FallbackController

  @spec index(Plug.Conn.t(), any) :: Plug.Conn.t()
  def index(conn, %{"driver_id" => driver_id} = params) do
    try do
      waypoints = Waypoints.all_elements(driver_id) |> Repo.paginate(params)
      render(conn, "index.json", waypoint: waypoints)
    rescue
      _ ->
      conn
      |> put_view(WaypointsProcessApiWeb.ErrorView)
      |> render("404.json", message: "driver #{driver_id} found")
    end
  end

  def index(conn, _), do: render(conn, "index.json", waypoint: [])

  def show(conn, %{"id" => id}) do
    try do
      waypoint = Waypoints.get_driver_associated_waypoint_by_id(id)
      render(conn, "show.json", waypoint: waypoint)
    rescue
      _ ->
        conn
        |> put_view(WaypointsProcessApiWeb.ErrorView)
        |> render("404.json", message: "Waypoint #{id} not found")
    end
  end

  def create(conn, %{"waypoint" => waypoint_params}) do
    case Waypoints.create_waypoint(waypoint_params) do
      {:ok, waypoint} ->
        WaypointsProcessApiWeb.WaypointChannel.broadcast_create(Waypoints.get_driver_associated(waypoint))
        conn
        |> put_status(:created)
        |> put_resp_header("location", Routes.waypoint_path(conn, :show, waypoint))
        |> render("show.json", waypoint: Waypoints.get_driver_associated(waypoint))
      {:error, changeset} ->
        conn
      |> put_status(:unprocessable_entity)
      |> put_view(WaypointsProcessApiWeb.ChangesetView)
      |> render("error.json", changeset: changeset)
    end
  end
end
