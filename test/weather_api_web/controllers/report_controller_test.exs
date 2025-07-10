defmodule WeatherApiWeb.ReportControllerTest do
  use WeatherApiWeb.ConnCase

  import WeatherApi.WeatherFixtures

  alias WeatherApi.Weather.Report

  @create_attrs %{
    description: "some description",
    city: "some city",
    temperature: 120.5,
    recorded_at: ~U[2025-07-09 09:02:00Z]
  }
  @update_attrs %{
    description: "some updated description",
    city: "some updated city",
    temperature: 456.7,
    recorded_at: ~U[2025-07-10 09:02:00Z]
  }
  @invalid_attrs %{description: nil, city: nil, temperature: nil, recorded_at: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all reports", %{conn: conn} do
      conn = get(conn, ~p"/api/reports")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create report" do
    test "renders report when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/reports", report: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/reports/#{id}")

      assert %{
               "id" => ^id,
               "city" => "some city",
               "description" => "some description",
               "recorded_at" => "2025-07-09T09:02:00Z",
               "temperature" => 120.5
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/reports", report: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update report" do
    setup [:create_report]

    test "renders report when data is valid", %{conn: conn, report: %Report{id: id} = report} do
      conn = put(conn, ~p"/api/reports/#{report}", report: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/reports/#{id}")

      assert %{
               "id" => ^id,
               "city" => "some updated city",
               "description" => "some updated description",
               "recorded_at" => "2025-07-10T09:02:00Z",
               "temperature" => 456.7
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, report: report} do
      conn = put(conn, ~p"/api/reports/#{report}", report: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete report" do
    setup [:create_report]

    test "deletes chosen report", %{conn: conn, report: report} do
      conn = delete(conn, ~p"/api/reports/#{report}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/reports/#{report}")
      end
    end
  end

  defp create_report(_) do
    report = report_fixture()
    %{report: report}
  end
end
