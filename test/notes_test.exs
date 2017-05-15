defmodule GeoNoteApi.NotesTest do
  use GeoNoteApi.DataCase

  alias GeoNoteApi.Notes
  alias GeoNoteApi.Notes.Note

  @create_attrs %{description: "some description", image_url: "some image_url", user_name: "some user_name"}
  @update_attrs %{description: "some updated description", image_url: "some updated image_url", user_name: "some updated user_name"}
  @invalid_attrs %{description: nil, image_url: nil, user_name: nil}

  def fixture(:note, attrs \\ @create_attrs) do
    {:ok, note} = Notes.create_note(attrs)
    note
  end

  test "list_notes/1 returns all notes" do
    note = fixture(:note)
    assert Notes.list_notes() == [note]
  end

  test "get_note! returns the note with given id" do
    note = fixture(:note)
    assert Notes.get_note!(note.id) == note
  end

  test "create_note/1 with valid data creates a note" do
    assert {:ok, %Note{} = note} = Notes.create_note(@create_attrs)
    assert note.description == "some description"
    assert note.image_url == "some image_url"
    assert note.user_name == "some user_name"
  end

  test "create_note/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = Notes.create_note(@invalid_attrs)
  end

  test "update_note/2 with valid data updates the note" do
    note = fixture(:note)
    assert {:ok, note} = Notes.update_note(note, @update_attrs)
    assert %Note{} = note
    assert note.description == "some updated description"
    assert note.image_url == "some updated image_url"
    assert note.user_name == "some updated user_name"
  end

  test "update_note/2 with invalid data returns error changeset" do
    note = fixture(:note)
    assert {:error, %Ecto.Changeset{}} = Notes.update_note(note, @invalid_attrs)
    assert note == Notes.get_note!(note.id)
  end

  test "delete_note/1 deletes the note" do
    note = fixture(:note)
    assert {:ok, %Note{}} = Notes.delete_note(note)
    assert_raise Ecto.NoResultsError, fn -> Notes.get_note!(note.id) end
  end

  test "change_note/1 returns a note changeset" do
    note = fixture(:note)
    assert %Ecto.Changeset{} = Notes.change_note(note)
  end
end
