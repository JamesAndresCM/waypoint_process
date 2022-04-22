defmodule WaypointsProcessApi.Drivers.DriverStatus do
  use Ecto.Schema

  @primary_key {:id, :id, autogenerate: true}

  schema "driver_statuses" do
    field :active, :boolean
    field :status, :integer
    field :created_at, :utc_datetime
    field :updated_at, :utc_datetime
    belongs_to :driver, WaypointsProcessApi.Drivers.Driver
  end
end
