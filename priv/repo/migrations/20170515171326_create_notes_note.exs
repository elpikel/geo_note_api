defmodule GeoNoteApi.Repo.Migrations.CreateGeoNoteApi.Notes.Note do
  use Ecto.Migration

  def change do
    create table(:notes_notes) do
      add :description, :string
      add :image_url, :string
      add :user_name, :string
      #add :place_id, references(:notes_places, on_delete: :nothing)

      timestamps()
    end

    #create index(:notes_notes, [:place_id])
  end
end
