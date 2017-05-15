defmodule GeoNoteApi.Web.PlaceView do
  use GeoNoteApi.Web, :view
  alias GeoNoteApi.Web.PlaceView

  def render("index.json", %{places: places}) do
    %{data: render_many(places, PlaceView, "place.json")}
  end

  def render("show.json", %{place: place}) do
    %{data: render_one(place, PlaceView, "place.json")}
  end

  def render("place.json", %{place: place}) do
    %{id: place.id,
      description: place.description,
      longitude: place.longitude,
      latitude: place.latitude}
  end
end
