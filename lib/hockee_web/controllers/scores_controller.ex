defmodule HockeeWeb.ScoresController do
  alias Hockee.GameTeamStats
  alias Hockee.GameScore
  use HockeeWeb, :controller

  def scores(conn, _params) do
    games = [
      %GameScore{
        away_team: %GameTeamStats{
          name: "Wild",
          goals: 4,
          sog: 32,
          logo: "https://assets.nhle.com/logos/nhl/svg/MIN_light.svg"
        },
        home_team: %GameTeamStats{
          name: "Jets",
          goals: 1,
          sog: 22,
          logo: "https://assets.nhle.com/logos/nhl/svg/WPG_light.svg"
        },
        clock: "00:00",
        period: 4,
        status: :finished,
        finish_type: :overtime,
        start_time: ~U[2023-06-26 13:30:00Z]
      },
      %GameScore{
        away_team: %GameTeamStats{
          name: "Golden Knights",
          goals: 0,
          sog: 32,
          logo: "https://assets.nhle.com/logos/nhl/svg/VGK_light.svg"
        },
        home_team: %GameTeamStats{
          name: "Blue Jackets",
          goals: 1,
          sog: 22,
          logo: "https://assets.nhle.com/logos/nhl/svg/CBJ_light.svg"
        },
        clock: "00:00",
        period: 3,
        status: :finished,
        finish_type: :regulation,
        start_time: ~U[2023-06-26 13:30:00Z]
      },
      %GameScore{
        away_team: %GameTeamStats{
          name: "Golden Knights",
          goals: 0,
          sog: 32,
          logo: "https://assets.nhle.com/logos/nhl/svg/VGK_light.svg"
        },
        home_team: %GameTeamStats{
          name: "Blue Jackets",
          goals: 1,
          sog: 22,
          logo: "https://assets.nhle.com/logos/nhl/svg/CBJ_light.svg"
        },
        clock: "12:10",
        period: 1,
        status: :in_progress,
        finish_type: nil,
        start_time: ~U[2023-06-26 13:30:00Z]
      },
      %GameScore{
        away_team: %GameTeamStats{
          name: "Golden Knights",
          goals: 0,
          sog: 32,
          logo: "https://assets.nhle.com/logos/nhl/svg/VGK_light.svg"
        },
        home_team: %GameTeamStats{
          name: "Blue Jackets",
          goals: 1,
          sog: 22,
          logo: "https://assets.nhle.com/logos/nhl/svg/CBJ_light.svg"
        },
        clock: "20:00",
        period: 1,
        status: :not_started,
        finish_type: nil,
        start_time: ~U[2023-06-26 13:30:00Z]
      }
    ]

    render(conn, :scores, games: games)
  end
end
