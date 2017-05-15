defmodule GeoNoteApi.Web.PlaceController do
  use GeoNoteApi.Web, :controller

  alias GeoNoteApi.Notes
  alias GeoNoteApi.Notes.Place

  action_fallback GeoNoteApi.Web.FallbackController

  def index(conn, _params) do
    places = Notes.list_places()
    render(conn, "index.json", places: places)
  end

  def create(conn, %{"place" => place_params}) do
    with {:ok, %Place{} = place} <- Notes.create_place(place_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", place_path(conn, :show, place))
      |> render("show.json", place: place)
    end
  end

  def show(conn, %{"id" => id}) do
    place = Notes.get_place!(id)
    render(conn, "show.json", place: place)
  end

  def update(conn, %{"id" => id, "place" => place_params}) do
    place = Notes.get_place!(id)

    with {:ok, %Place{} = place} <- Notes.update_place(place, place_params) do
      render(conn, "show.json", place: place)
    end
  end

  def delete(conn, %{"id" => id}) do
    place = Notes.get_place!(id)
    with {:ok, %Place{}} <- Notes.delete_place(place) do
      send_resp(conn, :no_content, "")
    end
  end
end
