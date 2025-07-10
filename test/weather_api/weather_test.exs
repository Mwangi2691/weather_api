defmodule WeatherApi.WeatherTest do
  use WeatherApi.DataCase

  alias WeatherApi.Weather

  describe "reports" do
    alias WeatherApi.Weather.Report

    import WeatherApi.WeatherFixtures

    @invalid_attrs %{description: nil, city: nil, temperature: nil, recorded_at: nil}

    test "list_reports/0 returns all reports" do
      report = report_fixture()
      assert Weather.list_reports() == [report]
    end

    test "get_report!/1 returns the report with given id" do
      report = report_fixture()
      assert Weather.get_report!(report.id) == report
    end

    test "create_report/1 with valid data creates a report" do
      valid_attrs = %{description: "some description", city: "some city", temperature: 120.5, recorded_at: ~U[2025-07-09 09:02:00Z]}

      assert {:ok, %Report{} = report} = Weather.create_report(valid_attrs)
      assert report.description == "some description"
      assert report.city == "some city"
      assert report.temperature == 120.5
      assert report.recorded_at == ~U[2025-07-09 09:02:00Z]
    end

    test "create_report/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Weather.create_report(@invalid_attrs)
    end

    test "update_report/2 with valid data updates the report" do
      report = report_fixture()
      update_attrs = %{description: "some updated description", city: "some updated city", temperature: 456.7, recorded_at: ~U[2025-07-10 09:02:00Z]}

      assert {:ok, %Report{} = report} = Weather.update_report(report, update_attrs)
      assert report.description == "some updated description"
      assert report.city == "some updated city"
      assert report.temperature == 456.7
      assert report.recorded_at == ~U[2025-07-10 09:02:00Z]
    end

    test "update_report/2 with invalid data returns error changeset" do
      report = report_fixture()
      assert {:error, %Ecto.Changeset{}} = Weather.update_report(report, @invalid_attrs)
      assert report == Weather.get_report!(report.id)
    end

    test "delete_report/1 deletes the report" do
      report = report_fixture()
      assert {:ok, %Report{}} = Weather.delete_report(report)
      assert_raise Ecto.NoResultsError, fn -> Weather.get_report!(report.id) end
    end

    test "change_report/1 returns a report changeset" do
      report = report_fixture()
      assert %Ecto.Changeset{} = Weather.change_report(report)
    end
  end
end
