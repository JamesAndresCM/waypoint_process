defmodule WaypointsProcessApiWeb.WaypointView do
  use WaypointsProcessApiWeb, :view
  alias WaypointsProcessApiWeb.WaypointView

  def render("index.json", %{waypoint: waypoint}) do
    meta_data = if !Enum.empty?(waypoint) do
                  %{
                      page_number: waypoint.page_number,
                      page_size: waypoint.page_size,
                      total_pages: waypoint.total_pages,
                      total_entries: waypoint.total_entries
                    }
                 end
    %{data: render_many(waypoint, WaypointView, "waypoint.json"), meta: meta_data}
  end

  def render("show.json", %{waypoint: waypoint}) do
    %{waypoint: render_one(waypoint, WaypointView, "waypoint.json")}
  end

  def render("waypoint.json", %{waypoint: waypoint}) do
    %{
      id: waypoint.id,
      driver_id: waypoint.driver_id,
      account_id: waypoint.account_id,
      latitude: waypoint.coordinates.y,
      longitude: waypoint.coordinates.x,
      sent_at: waypoint.sent_at,
      driver: %{
        id: waypoint.driver_id,
        email: waypoint.driver.email,
        name: waypoint.driver.name,
        lastname: waypoint.driver.lastname,
        identifier: waypoint.driver.identifier,
        phone: waypoint.driver.phone
      }
    }
  end
end
