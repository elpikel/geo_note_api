defmodule GeoNoteApi.Repo.Migrations.CreateGeoNoteApi.Notes.Place do
  use Ecto.Migration

  def change do
    create table(:notes_places) do
      add :description, :string
      add :longitude, :float
      add :latitude, :float

      timestamps()
    end

  end
end
