defmodule GeoNoteApi.Notes.Note do
  use Ecto.Schema

  schema "notes_notes" do
    field :description, :string
    field :image_url, :string
    field :user_name, :string 
    field :place_id, :id

    timestamps()
  end
end
