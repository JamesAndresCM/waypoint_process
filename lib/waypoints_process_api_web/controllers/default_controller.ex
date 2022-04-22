defmodule WaypointsProcessApiWeb.DefaultController do
  use WaypointsProcessApiWeb, :controller

  def index(conn, _params) do
    json(conn, %{routes: get_routes()})
  end

  def alive(conn, _params) do
    json(conn, %{msg: "Alive Path"})
  end

  defp get_routes do
    Enum.filter(WaypointsProcessApiWeb.Router.__routes__, fn x -> x.helper == "waypoint" end)
    |> Enum.map(fn x -> %{path: x.path, verb: x.verb} end)
  end
end
