defmodule Hockee.MappersTest do
  alias Hockee.GameTeamStats
  alias Hockee.GameScore
  alias Hockee.Mappers
  use ExUnit.Case

  test "map_to_game_score should map NHL game score API response to a GameScore" do
    expected = %GameScore{
      start_time: ~U[2024-02-27 02:30:00Z],
      status: :in_progress,
      clock: "12:25",
      period: 2,
      away_team: %GameTeamStats{
        name: "Kings",
        logo: "https://assets.nhle.com/logos/nhl/svg/LAK_light.svg",
        goals: 2,
        sog: 26
      },
      home_team: %GameTeamStats{
        name: "Oilers",
        logo: "https://assets.nhle.com/logos/nhl/svg/EDM_light.svg",
        goals: 2,
        sog: 21
      }
    }

    actual = Mappers.map_to_game_score(NHLApiScoresFixtures.game_score_fixture())

    assert actual == expected
  end

  test "map_to_game_score should map to a GameScore with status not started" do
    actual =
      Mappers.map_to_game_score(
        NHLApiScoresFixtures.game_score_fixture(
          %{
            "gameState" => "FUT"
          },
          [
            "clock",
            "gameOutcome",
            "period"
          ]
        )
      )

    assert actual.status == :not_started

    actual =
      Mappers.map_to_game_score(
        NHLApiScoresFixtures.game_score_fixture(
          %{
            "gameState" => "PRE"
          },
          [
            "clock",
            "gameOutcome",
            "period"
          ]
        )
      )

    assert actual.status == :not_started
  end

  test "map_to_game_score should map to a GameScore with status finished" do
    actual =
      Mappers.map_to_game_score(
        NHLApiScoresFixtures.game_score_fixture(%{
          "gameState" => "FINAL",
          "gameOutcome" => %{"lastPeriodType" => "REG"}
        })
      )

    assert actual.status == :finished
    assert actual.finish_type == :regulation

    actual =
      Mappers.map_to_game_score(
        NHLApiScoresFixtures.game_score_fixture(%{
          "gameState" => "FINAL",
          "gameOutcome" => %{"lastPeriodType" => "OT"}
        })
      )

    assert actual.status == :finished
    assert actual.finish_type == :overtime

    actual =
      Mappers.map_to_game_score(
        NHLApiScoresFixtures.game_score_fixture(%{
          "gameState" => "FINAL",
          "gameOutcome" => %{"lastPeriodType" => "SO"}
        })
      )

    assert actual.status == :finished
    assert actual.finish_type == :shootout
  end
end
