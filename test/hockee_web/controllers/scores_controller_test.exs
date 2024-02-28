defmodule HockeeWeb.ScoresControllerTest do
  use HockeeWeb.ConnCase

  test "GET /scores", %{conn: conn} do
    Req.Test.stub(Hockee.NHLClient, fn conn ->
      Req.Test.json(conn, %{"games" => [NHLApiScoresFixtures.game_score_fixture()]})
    end)

    conn = get(conn, ~p"/scores")
    html = html_response(conn, 200)

    assert html =~ "NHL Scores"
    assert html =~ "Kings"
    assert html =~ "2 – 2"
    assert html =~ "Oilers"
  end
end
