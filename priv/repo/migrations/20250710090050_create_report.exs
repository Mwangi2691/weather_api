defmodule WeatherApi.Repo.Migrations.CreateReport do
  use Ecto.Migration

  def change do
    create table(:report) do
      add :reports, :string
      add :city, :string
      add :temperature, :float
      add :description, :string
      add :recorded_at, :utc_datetime

      timestamps(type: :utc_datetime)
    end
  end
end
