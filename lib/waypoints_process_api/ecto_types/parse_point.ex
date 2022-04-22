defmodule WaypointsProcessApi.EctoTypes.ParsePoint do
  @behaviour Ecto.Type
  def type, do: Postgrex.Point

  # Casting from input into point struct
  def cast(value = %Postgrex.Point{}), do: {:ok, value}
  def cast(_), do: :error

  # loading data from the database
  def load(data) do
    {:ok, data}
  end

  def equal?(term1, term2) do
    term1 == term2
  end

  # dumping data to the database
  def dump(value = %Postgrex.Point{}), do: {:ok, value}
  def dump(_), do: :error
end
