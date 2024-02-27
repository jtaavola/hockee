defmodule Hockee.GameScoreFixtures do
  alias Hockee.GameTeamStats
  alias Hockee.GameScore

  @spec game_team_stats_fixture(map()) :: GameTeamStats.t()
  def game_team_stats_fixture(attrs \\ %{}) do
    %GameTeamStats{
      name: "Wild",
      logo: "https://assets.nhle.com/logos/nhl/svg/MIN_light.svg"
    }
    |> struct!(attrs)
  end

  @spec game_score_fixture(map()) :: GameScore.t()
  def game_score_fixture(attrs \\ %{}) do
    %GameScore{
      start_time: ~U[2024-02-25 03:00:00Z],
      status: :finished,
      finish_type: :regulation,
      clock: "00:00",
      period: 3,
      home_team:
        game_team_stats_fixture(%{
          name: "Kraken",
          logo: "https://assets.nhle.com/logos/nhl/svg/SEA_light.svg"
        }),
      away_team: game_team_stats_fixture()
    }
    |> struct!(attrs)
  end
end
