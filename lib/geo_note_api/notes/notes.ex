defmodule GeoNoteApi.Notes do
  @moduledoc """
  The boundary for the Notes system.
  """

  import Ecto.{Query, Changeset}, warn: false
  alias GeoNoteApi.Repo

  alias GeoNoteApi.Notes.Note
  alias GeoNoteApi.Notes.Place

  @doc """
  Returns the list of notes.

  ## Examples

      iex> list_notes()
      [%Note{}, ...]

  """
  def list_notes(place_id) do
    Repo.all(from n in Note, where: n.place_id == ^place_id)
  end

  def list_notes() do
    Repo.all(Note)
  end

  @doc """
  Gets a single note.

  Raises `Ecto.NoResultsError` if the Note does not exist.

  ## Examples

      iex> get_note!(123)
      %Note{}

      iex> get_note!(456)
      ** (Ecto.NoResultsError)

  """
  def get_note!(id), do: Repo.get!(Note, id)

  @doc """
  Creates a note.

  ## Examples

      iex> create_note(%{field: value})
      {:ok, %Note{}}

      iex> create_note(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_note(attrs \\ %{}) do
    if !Map.has_key?(attrs, "place_id") do
      {:ok, %Place{} = place} = create_place(attrs)
      attrs = Map.put(attrs, "place_id", place.id)
    end

    %Note{}
    |> note_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a note.

  ## Examples

      iex> update_note(note, %{field: new_value})
      {:ok, %Note{}}

      iex> update_note(note, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_note(%Note{} = note, attrs) do
    note
    |> note_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Note.

  ## Examples

      iex> delete_note(note)
      {:ok, %Note{}}

      iex> delete_note(note)
      {:error, %Ecto.Changeset{}}

  """
  def delete_note(%Note{} = note) do
    Repo.delete(note)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking note changes.

  ## Examples

      iex> change_note(note)
      %Ecto.Changeset{source: %Note{}}

  """
  def change_note(%Note{} = note) do
    note_changeset(note, %{})
  end

  defp note_changeset(%Note{} = note, attrs) do
    note
    |> cast(attrs, [:description, :user_name, :image_url, :place_id])
    |> validate_required([:description, :user_name])
  end



  @doc """
  Returns the list of places.

  ## Examples

      iex> list_places(latitude, longitude)
      [%Place{}, ...]

  """
  def list_places(latitude, longitude) do
    Repo.all(from place in Place, where: place.latitude <= ^latitude and place.longitude <= ^longitude)
  end

  def list_places() do
    Repo.all(Place)
  end

  @doc """
  Gets a single place.

  Raises `Ecto.NoResultsError` if the Place does not exist.

  ## Examples

      iex> get_place!(123)
      %Place{}

      iex> get_place!(456)
      ** (Ecto.NoResultsError)

  """
  def get_place!(id), do: Repo.get!(Place, id)

  @doc """
  Creates a place.

  ## Examples

      iex> create_place(%{field: value})
      {:ok, %Place{}}

      iex> create_place(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_place(attrs \\ %{}) do
    %Place{}
    |> place_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a place.

  ## Examples

      iex> update_place(place, %{field: new_value})
      {:ok, %Place{}}

      iex> update_place(place, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_place(%Place{} = place, attrs) do
    place
    |> place_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Place.

  ## Examples

      iex> delete_place(place)
      {:ok, %Place{}}

      iex> delete_place(place)
      {:error, %Ecto.Changeset{}}

  """
  def delete_place(%Place{} = place) do
    Repo.delete(place)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking place changes.

  ## Examples

      iex> change_place(place)
      %Ecto.Changeset{source: %Place{}}

  """
  def change_place(%Place{} = place) do
    place_changeset(place, %{})
  end

  defp place_changeset(%Place{} = place, attrs) do
    place
    |> cast(attrs, [:description, :longitude, :latitude])
    |> validate_required([:description, :longitude, :latitude])
  end
end
