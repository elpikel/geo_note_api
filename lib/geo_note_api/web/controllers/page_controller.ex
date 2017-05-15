defmodule GeoNoteApi.Web.PageController do
  use GeoNoteApi.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
