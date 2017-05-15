defmodule GeoNoteApi.Web.NoteView do
  use GeoNoteApi.Web, :view
  alias GeoNoteApi.Web.NoteView

  def render("index.json", %{notes: notes}) do
    render_many(notes, NoteView, "note.json")
  end

  def render("show.json", %{note: note}) do
    render_one(note, NoteView, "note.json")
  end

  def render("note.json", %{note: note}) do
    %{id: note.id,
      description: note.description,
      image_url: note.image_url,
      user_name: note.user_name,
      place_id: note.place_id}
  end
end
