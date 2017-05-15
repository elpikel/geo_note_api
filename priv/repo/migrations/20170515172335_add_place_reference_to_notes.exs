defmodule GeoNoteApi.Repo.Migrations.AddPlaceReferenceToNotes do
  use Ecto.Migration

  def change do
    alter table(:notes_notes) do
      add :place_id, references(:notes_places, on_delete: :nothing)
    end

    create index(:notes_notes, [:place_id])
  end
end
