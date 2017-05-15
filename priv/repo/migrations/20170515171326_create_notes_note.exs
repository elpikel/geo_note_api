defmodule GeoNoteApi.Repo.Migrations.CreateGeoNoteApi.Notes.Note do
  use Ecto.Migration

  def change do
    create table(:notes_notes) do
      add :description, :string
      add :image_url, :string
      add :user_name, :string

      timestamps()
    end
  end
end
