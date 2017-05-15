defmodule GeoNoteApi.Web.NoteControllerTest do
  use GeoNoteApi.Web.ConnCase

  alias GeoNoteApi.Notes
  alias GeoNoteApi.Notes.Note

  @create_attrs %{description: "some description", image_url: "some image_url", user_name: "some user_name"}
  @update_attrs %{description: "some updated description", image_url: "some updated image_url", user_name: "some updated user_name"}
  @invalid_attrs %{description: nil, image_url: nil, user_name: nil}

  def fixture(:note) do
    {:ok, note} = Notes.create_note(@create_attrs)
    note
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, note_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "creates note and renders note when data is valid", %{conn: conn} do
    conn = post conn, note_path(conn, :create), note: @create_attrs
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get conn, note_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "description" => "some description",
      "image_url" => "some image_url",
      "user_name" => "some user_name"}
  end

  test "does not create note and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, note_path(conn, :create), note: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen note and renders note when data is valid", %{conn: conn} do
    %Note{id: id} = note = fixture(:note)
    conn = put conn, note_path(conn, :update, note), note: @update_attrs
    assert %{"id" => ^id} = json_response(conn, 200)["data"]

    conn = get conn, note_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "description" => "some updated description",
      "image_url" => "some updated image_url",
      "user_name" => "some updated user_name"}
  end

  test "does not update chosen note and renders errors when data is invalid", %{conn: conn} do
    note = fixture(:note)
    conn = put conn, note_path(conn, :update, note), note: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen note", %{conn: conn} do
    note = fixture(:note)
    conn = delete conn, note_path(conn, :delete, note)
    assert response(conn, 204)
    assert_error_sent 404, fn ->
      get conn, note_path(conn, :show, note)
    end
  end
end
