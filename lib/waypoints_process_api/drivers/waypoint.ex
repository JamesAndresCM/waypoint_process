defmodule WaypointsProcessApi.Drivers.Waypoint do
  use Ecto.Schema
  import Ecto.Changeset
  alias WaypointsProcessApi.Drivers.Waypoint

  @primary_key {:id, :id, autogenerate: true}

  schema "waypoints" do
    field :account_id, :integer
    field :coordinates, WaypointsProcessApi.EctoTypes.ParsePoint
    field :latitude, :float, virtual: true
    field :longitude, :float, virtual: true
    field :sent_at, :utc_datetime
    field :active, :boolean, default: true
    timestamps(inserted_at: :created_at)
    belongs_to :driver, WaypointsProcessApi.Drivers.Driver
  end

  def changeset(%Waypoint{} = waypoint, attrs \\ %{}) do
    waypoint
    |> cast(attrs, [:driver_id, :account_id, :latitude, :longitude])
    |> validate_required([:driver_id, :account_id, :latitude, :longitude])
    |> put_long_lat() 
    |> put_change(:sent_at, DateTime.truncate(DateTime.utc_now, :second))
  end

  defp put_long_lat(changeset) do
    lat = get_field(changeset, :latitude)
    lng = get_field(changeset, :longitude)
    point = %Postgrex.Point{x: lng, y: lat}
    changeset |> put_change(:coordinates, point)
  end
end
