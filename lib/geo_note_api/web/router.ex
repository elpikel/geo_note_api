defmodule GeoNoteApi.Web.Router do
  use GeoNoteApi.Web, :router

  pipeline :browser do
    plug :accepts, ["html", "json"]
    plug :fetch_session
    plug :fetch_flash
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", GeoNoteApi.Web do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    resources "/notes", NoteController
    resources "/places", PlaceController
  end

  # Other scopes may use custom stacks.
  # scope "/api", GeoNoteApi.Web do
  #   pipe_through :api
  # end
end
