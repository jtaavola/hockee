defmodule HockeeWeb.ScoresController do
  alias Hockee.NHLClient
  alias Hockee.Mappers
  use HockeeWeb, :controller

  def scores(conn, _params) do
    games =
      DateTime.now!("America/Chicago")
      |> DateTime.to_date()
      |> NHLClient.getScores!()
      |> Map.fetch!("games")
      |> Enum.map(&Mappers.map_to_game_score/1)

    render(conn, :scores, games: games)
  end
end
