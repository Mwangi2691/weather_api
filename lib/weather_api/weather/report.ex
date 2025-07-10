defmodule WeatherApi.Weather.Report do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :description, :city, :temperature, :recorded_at, :inserted_at, :updated_at]}
  schema "reports" do
    field :description, :string
    field :city, :string
    field :temperature, :float
    field :recorded_at, :utc_datetime

    timestamps()
  end

  def changeset(report, attrs) do
    report
    |> cast(attrs, [:description, :city, :temperature, :recorded_at])
    |> validate_required([:description, :city, :temperature, :recorded_at])
  end
end
