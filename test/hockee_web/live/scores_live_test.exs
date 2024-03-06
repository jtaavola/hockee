defmodule HockeeWeb.ScoresLiveTest do
  import Phoenix.LiveViewTest
  alias Hockee.GameTeamStats
  alias Hockee.GameScoreFixtures
  use HockeeWeb.ConnCase, async: true

  test "GET /", %{conn: conn} do
    Req.Test.stub(Hockee.NHLClient, fn conn ->
      Req.Test.json(conn, %{"games" => [NHLApiScoresFixtures.game_score_fixture()]})
    end)

    {:ok, _view, html} = live(conn, ~p"/")
    assert html =~ "NHL Scores"
    assert html =~ "Kings"
    assert html =~ "2 – 2"
    assert html =~ "Oilers"
  end

  test "GET /scores", %{conn: conn} do
    Req.Test.stub(Hockee.NHLClient, fn conn ->
      Req.Test.json(conn, %{"games" => [NHLApiScoresFixtures.game_score_fixture()]})
    end)

    {:ok, _view, html} = live(conn, ~p"/scores")
    assert html =~ "NHL Scores"
    assert html =~ "Kings"
    assert html =~ "2 – 2"
    assert html =~ "Oilers"
  end

  test "game clock should show FINAL when game is finished" do
    rendered =
      render_component(HockeeWeb.ScoresLive,
        games: [
          GameScoreFixtures.game_score_fixture(%{
            status: :finished,
            finish_type: :regulation,
            clock: "00:00"
          })
        ]
      )

    assert rendered =~ "FINAL"
  end

  test "game clock should show FINAL/OT when game ended in overtime" do
    rendered =
      render_component(HockeeWeb.ScoresLive,
        games: [
          GameScoreFixtures.game_score_fixture(%{
            status: :finished,
            finish_type: :overtime,
            clock: "00:00"
          })
        ]
      )

    assert rendered =~ "FINAL/OT"
  end

  test "game clock should show FINAL/SO when game ended in a shootout" do
    rendered =
      render_component(HockeeWeb.ScoresLive,
        games: [
          GameScoreFixtures.game_score_fixture(%{
            status: :finished,
            finish_type: :shootout,
            clock: "00:00"
          })
        ]
      )

    assert rendered =~ "FINAL"
  end

  test "game clock should show the start time when game has not started" do
    rendered =
      render_component(HockeeWeb.ScoresLive,
        games: [
          GameScoreFixtures.game_score_fixture(%{
            status: :not_started,
            clock: "20:00",
            start_time: ~U[2024-02-25 03:00:00Z]
          })
        ]
      )

    assert rendered =~ "9:00 PM CST"
  end

  test "game clock should show the time remaining when game is in progress" do
    rendered =
      render_component(HockeeWeb.ScoresLive,
        games: [
          GameScoreFixtures.game_score_fixture(%{
            status: :in_progress,
            clock: "10:20",
            period: 1
          })
        ]
      )

    assert rendered =~ "1st 10:20"

    rendered =
      render_component(HockeeWeb.ScoresLive,
        games: [
          GameScoreFixtures.game_score_fixture(%{
            status: :in_progress,
            clock: "10:20",
            period: 2
          })
        ]
      )

    assert rendered =~ "2nd 10:20"

    rendered =
      render_component(HockeeWeb.ScoresLive,
        games: [
          GameScoreFixtures.game_score_fixture(%{
            status: :in_progress,
            clock: "10:20",
            period: 3
          })
        ]
      )

    assert rendered =~ "3rd 10:20"

    rendered =
      render_component(HockeeWeb.ScoresLive,
        games: [
          GameScoreFixtures.game_score_fixture(%{
            status: :in_progress,
            clock: "10:20",
            period: 4
          })
        ]
      )

    assert rendered =~ "OT 10:20"

    rendered =
      render_component(HockeeWeb.ScoresLive,
        games: [
          GameScoreFixtures.game_score_fixture(%{
            status: :in_progress,
            clock: "10:20",
            period: 5
          })
        ]
      )

    assert rendered =~ "2OT 10:20"
  end

  test "should show record instead of SOG if game has not started" do
    rendered =
      render_component(HockeeWeb.ScoresLive,
        games: [
          GameScoreFixtures.game_score_fixture(%{
            status: :not_started,
            away_team: %GameTeamStats{
              name: "Hurricanes",
              logo: "fake logo",
              record: "12-10-1"
            },
            home_team: %GameTeamStats{
              name: "Wild",
              logo: "fake logo",
              record: "82-0-0"
            }
          })
        ]
      )

    assert rendered =~ "12-10-1"
    assert rendered =~ "82-0-0"
    assert not (rendered =~ "SOG")
  end
end
