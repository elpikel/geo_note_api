defmodule GeoNoteApi.Notes do
  import Ecto.{Query, Changeset}, warn: false
  alias GeoNoteApi.Repo

  alias GeoNoteApi.Notes.Note
  alias GeoNoteApi.Notes.Place

  def list_notes(place_id) do
    Repo.all(from n in Note, where: n.place_id == ^place_id)
  end

  def list_notes() do
    Repo.all(Note)
  end

  def get_note!(id), do: Repo.get!(Note, id)

  def create_note(attrs \\ %{}) do
    case create_place_for_note(attrs) do
      {:ok, attrs} ->
        %Note{}
        |> note_changeset(attrs)
        |> Repo.insert()
      {:error, changeset} -> {:error, changeset}
    end
  end

  defp create_place_for_note(%{"place_id" => _place_id} = attrs) do
    {:ok, attrs}
  end
  defp create_place_for_note(attrs) do
    case create_place(attrs) do
      {:ok, %Place{} = place} -> {:ok, Map.put(attrs, "place_id", Integer.to_string(place.id)) }
      {:error, changeset} -> {:error, changeset}
    end
  end

  def update_note(%Note{} = note, attrs) do
    note
    |> note_changeset(attrs)
    |> Repo.update()
  end

  def delete_note(%Note{} = note) do
    Repo.delete(note)
  end

  def change_note(%Note{} = note) do
    note_changeset(note, %{})
  end

  defp note_changeset(%Note{} = note, attrs) do
    note
    |> cast(attrs, [:description, :user_name, :image_url, :place_id])
    |> validate_required([:description, :user_name, :place_id])
  end

  def list_places(latitude, longitude) do
    Repo.all(from place in Place, where: place.latitude <= ^latitude and place.longitude <= ^longitude)
  end

  def list_places() do
    Repo.all(Place)
  end

  def get_place!(id), do: Repo.get!(Place, id)

  def create_place(attrs \\ %{}) do
    %Place{}
    |> place_changeset(attrs)
    |> Repo.insert()
  end

  def update_place(%Place{} = place, attrs) do
    place
    |> place_changeset(attrs)
    |> Repo.update()
  end

  def delete_place(%Place{} = place) do
    Repo.delete(place)
  end

  def change_place(%Place{} = place) do
    place_changeset(place, %{})
  end

  defp place_changeset(%Place{} = place, attrs) do
    place
    |> cast(attrs, [:description, :longitude, :latitude])
    |> validate_required([:description, :longitude, :latitude])
  end
end
