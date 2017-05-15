defmodule GeoNoteApi.Notes.Place do
  use Ecto.Schema

  schema "notes_places" do
    field :description, :string
    field :langitude, :float
    field :longitude, :float

    timestamps()
  end
end
