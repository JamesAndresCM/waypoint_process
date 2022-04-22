defmodule WaypointsProcessApi.Drivers.Driver do
  use Ecto.Schema

  @primary_key {:id, :id, autogenerate: true}

  schema "drivers" do
    field :email, :string
    field :name, :string
    field :lastname, :string
    field :identifier, :string
    field :phone, :string
    field :last_status, Ecto.Enum, values: [unavailable: 0, busy: 1, available: 2]
    timestamps(inserted_at: :created_at)
    field :active, :boolean
    has_many :driver_statuses, WaypointsProcessApi.Drivers.DriverStatus
    has_many :waypoints, WaypointsProcessApi.Drivers.Waypoint
  end
end
