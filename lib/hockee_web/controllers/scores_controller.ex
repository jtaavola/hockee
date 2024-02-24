defmodule HockeeWeb.ScoresController do
  use HockeeWeb, :controller

  def scores(conn, _params) do
    games = [
      %{
        awayTeam: %{
          name: "Wild",
          goals: 4,
          sog: 32,
          logo: "https://assets.nhle.com/logos/nhl/svg/MIN_light.svg"
        },
        homeTeam: %{
          name: "Jets",
          goals: 1,
          sog: 22,
          logo: "https://assets.nhle.com/logos/nhl/svg/WPG_light.svg"
        },
        clock: "FINAL"
      },
      %{
        awayTeam: %{
          name: "Golden Knights",
          goals: 0,
          sog: 32,
          logo: "https://assets.nhle.com/logos/nhl/svg/VGK_light.svg"
        },
        homeTeam: %{
          name: "Blue Jackets",
          goals: 1,
          sog: 22,
          logo: "https://assets.nhle.com/logos/nhl/svg/CBJ_light.svg"
        },
        clock: "FINAL"
      }
    ]

    render(conn, :scores, games: games)
  end
end
