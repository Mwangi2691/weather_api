defmodule WeatherApiWeb.ReportJSON do
  alias WeatherApi.Weather.Report

  @doc """
  Renders a list of reports.
  """
  def index(%{reports: reports}) do
    %{data: for(report <- reports, do: data(report))}
  end

  @doc """
  Renders a single report.
  """
  def show(%{report: report}) do
    %{data: data(report)}
  end

  defp data(%Report{} = report) do
    %{
      id: report.id,
      city: report.city,
      temperature: report.temperature,
      description: report.description,
      recorded_at: report.recorded_at
    }
  end
end
