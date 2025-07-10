defmodule WeatherApi.Repo.Migrations.CreateReports do
  use Ecto.Migration

  def change do
    create table(:reports) do
      add :city, :string
      add :temperature, :float
      add :description, :string
      add :recorded_at, :utc_datetime

      timestamps(type: :utc_datetime)
    end
  end
end
