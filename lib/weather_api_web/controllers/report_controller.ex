defmodule WeatherApiWeb.ReportController do
  use WeatherApiWeb, :controller

  alias WeatherApi.Weather
  alias WeatherApi.Weather.Report

  action_fallback WeatherApiWeb.FallbackController

  @doc "Creates a weather report"
  def create(conn, %{"report" => report_params}) do
    case Weather.create_report(report_params) do
      {:ok, report} ->
        conn
        |> put_status(:created)
        |> json(report)

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{errors: Ecto.Changeset.traverse_errors(changeset, &translate_error/1)})
    end
  end

  @doc "Returns a weather report by ID"
  def show(conn, %{"id" => id}) do
    report = Weather.get_report!(id)
    render(conn, :show, report: report)
  end

  @doc "Updates a weather report"
  def update(conn, %{"id" => id, "report" => report_params}) do
    report = Weather.get_report!(id)

    with {:ok, %Report{} = report} <- Weather.update_report(report, report_params) do
      render(conn, :show, report: report)
    end
  end

  @doc "Deletes a weather report"
  def delete(conn, %{"id" => id}) do
    report = Weather.get_report!(id)

    with {:ok, %Report{}} <- Weather.delete_report(report) do
      send_resp(conn, :no_content, "")
    end
  end

  # Private helper to translate Ecto validation errors
  defp translate_error({msg, opts}) do
    Enum.reduce(opts, msg, fn {key, value}, acc ->
      String.replace(acc, "%{#{key}}", to_string(value))
    end)
  end
end
