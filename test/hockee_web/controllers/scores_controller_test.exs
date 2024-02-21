defmodule HockeeWeb.ScoresControllerTest do
  use HockeeWeb.ConnCase

  test "GET /scores", %{conn: conn} do
    conn = get(conn, ~p"/scores")
    assert html_response(conn, 200) =~ "NHL Scores"
  end
end
