defmodule WaypointsProcessApiWeb.WaypointChannel do
  use WaypointsProcessApiWeb, :channel

  @impl true
  def join("waypoints", _, socket) do
    {:ok, "Joined waypoints", socket}
  end

  @impl true
  def handle_out(event, payload, socket) do
    push socket, event, payload
    {:noreply, socket}
  end

  def broadcast_create(waypoint) do
    payload = %{
      "id" => waypoint.id,
      "latitude" => waypoint.coordinates.x,
      "longitude" => waypoint.coordinates.y,
      "sent_at" => to_string(waypoint.sent_at),
      "driver" => %{
        "id" => waypoint.driver_id,
        "name" => waypoint.driver.name,
        "lastname" => waypoint.driver.lastname,
        "identifier" => waypoint.driver.identifier
      }
    }
    WaypointsProcessApiWeb.Endpoint.broadcast("waypoints", "app/WaypointsPage/HAS_NEW_WAYPOINTS", payload)
  end
  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  @impl true
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (waypoint:lobby).
  @impl true
  def handle_in("shout", payload, socket) do
    broadcast(socket, "shout", payload)
    {:noreply, socket}
  end
end
