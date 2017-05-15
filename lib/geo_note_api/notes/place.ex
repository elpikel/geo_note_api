defmodule GeoNoteApi.Notes.Place do
  use Ecto.Schema

  schema "notes_places" do
    field :description, :string
    field :longitude, :float
    field :latitude, :float

    timestamps()
  end
end
