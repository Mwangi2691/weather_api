defmodule WeatherApi.Repo.Migrations.RemoveDescriptionFromReports do
  use Ecto.Migration

  def change do
    alter table (:reports) do
    remove :description
    end
  end
end
