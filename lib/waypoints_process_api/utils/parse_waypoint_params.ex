defmodule WaypointsProcessApi.Utils.ParseWaypointParams do
  def parse_params(key, params) when is_map_key(params, key) do
    params = Map.merge(params, %{
      latitude: params[key]["latitude"],
      longitude: params[key]["longitude"]
    })
    delete_keys(key, params) |> convert_string_to_atom
  end

  def parse_params(_, params), do: params

  defp delete_keys(key, params) when is_map(params) do
    Map.delete(params, key)
  end

  defp convert_string_to_atom(params) when is_map(params)  do
    params |> Map.new(fn {k, v} -> if is_atom(k) do {k, v} else {String.to_atom(k), v} end end)
  end
end