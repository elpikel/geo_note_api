defmodule GeoNoteApi.Web.PlaceControllerTest do
  use GeoNoteApi.Web.ConnCase

  alias GeoNoteApi.Notes
  alias GeoNoteApi.Notes.Place

  @create_attrs %{description: "some description", langitude: "120.5", longitude: "120.5"}
  @update_attrs %{description: "some updated description", langitude: "456.7", longitude: "456.7"}
  @invalid_attrs %{description: nil, langitude: nil, longitude: nil}

  def fixture(:place) do
    {:ok, place} = Notes.create_place(@create_attrs)
    place
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, place_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "creates place and renders place when data is valid", %{conn: conn} do
    conn = post conn, place_path(conn, :create), place: @create_attrs
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get conn, place_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "description" => "some description",
      "langitude" => "120.5",
      "longitude" => "120.5"}
  end

  test "does not create place and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, place_path(conn, :create), place: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen place and renders place when data is valid", %{conn: conn} do
    %Place{id: id} = place = fixture(:place)
    conn = put conn, place_path(conn, :update, place), place: @update_attrs
    assert %{"id" => ^id} = json_response(conn, 200)["data"]

    conn = get conn, place_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "description" => "some updated description",
      "langitude" => "456.7",
      "longitude" => "456.7"}
  end

  test "does not update chosen place and renders errors when data is invalid", %{conn: conn} do
    place = fixture(:place)
    conn = put conn, place_path(conn, :update, place), place: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen place", %{conn: conn} do
    place = fixture(:place)
    conn = delete conn, place_path(conn, :delete, place)
    assert response(conn, 204)
    assert_error_sent 404, fn ->
      get conn, place_path(conn, :show, place)
    end
  end
end
