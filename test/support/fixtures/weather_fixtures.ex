defmodule WeatherApi.WeatherFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `WeatherApi.Weather` context.
  """

  @doc """
  Generate a report.
  """
  def report_fixture(attrs \\ %{}) do
    {:ok, report} =
      attrs
      |> Enum.into(%{
        city: "some city",
        description: "some description",
        recorded_at: ~U[2025-07-09 09:02:00Z],
        temperature: 120.5
      })
      |> WeatherApi.Weather.create_report()

    report
  end
end
