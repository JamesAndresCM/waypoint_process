defmodule WaypointsProcessApiWeb.WaypointControllerTest do
  use WaypointsProcessApiWeb.ConnCase
  alias WaypointsProcessApi.Repo
  alias WaypointsProcessApi.Drivers.Driver
  alias WaypointsProcessApi.Drivers.Waypoints

  @create_attrs %{latitude: -220, longitude: 200, account_id: 1}
  @alternative_attrs %{account_id: 1, coordinates: %{latitude: 30, longitude: 20}}
  @invalid_attrs %{account_id: 1}

  def fixture(:waypoint) do
    driver = create_driver
    waypoint_params = Map.put(@create_attrs, :driver_id, driver.id)
    Waypoints.create_waypoint(waypoint_params)
  end

  def fixture(:driver) do
    Repo.insert!(%Driver{})
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "create waypoint" do
    test "renders waypoint when data is valid", %{conn: conn} do
      driver = create_driver
      waypoint_params = Map.put(@create_attrs, :driver_id, driver.id)
      conn = post(conn, Routes.waypoint_path(conn, :create), waypoint: waypoint_params)
      assert %{"id" => _} = json_response(conn, 201)["waypoint"]
    end

    test "alternative coordinates", %{conn: conn} do
      driver = create_driver
      waypoint_params = Map.put(@alternative_attrs, :driver_id, driver.id)
      conn = post(conn, Routes.waypoint_path(conn, :create), waypoint: waypoint_params)
      assert %{"id" => _} = json_response(conn, 201)["waypoint"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, Routes.waypoint_path(conn, :create), waypoint: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "show waypoint" do
    test "renders waypoint when data is valid", %{conn: conn} do
      {:ok, waypoint} = create_waypoint
      conn = get conn, Routes.waypoint_path(conn, :show, waypoint)
      assert response(conn, 200)
      #assert Repo.get(Business, business.id) == nil
    end
  end

  def create_waypoint do
    fixture(:waypoint)
  end

  def create_driver do
    fixture(:driver)
  end
end
