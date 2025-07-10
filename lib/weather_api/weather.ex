defmodule WeatherApi.Weather do
  @moduledoc """
  The Weather context handles operations related to weather reports.
  """

  import Ecto.Query, warn: false
  alias WeatherApi.Repo
  alias WeatherApi.Weather.Report

  @doc "Creates a new weather report"
  def create_report(attrs \\ %{}) do
    %Report{}
    |> Report.changeset(attrs)
    |> Repo.insert()
  end

  @doc "Retrieves a weather report by ID (raises if not found)"
  def get_report!(id), do: Repo.get!(Report, id)

  @doc "Updates an existing weather report"
  def update_report(%Report{} = report, attrs) do
    report
    |> Report.changeset(attrs)
    |> Repo.update()
  end

  @doc "Deletes a weather report"
  def delete_report(%Report{} = report) do
    Repo.delete(report)
  end
end
