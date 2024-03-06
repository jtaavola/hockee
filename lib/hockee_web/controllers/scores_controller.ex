defmodule HockeeWeb.ScoresController do
  alias Hockee.NHLService
  use HockeeWeb, :controller

  def scores(conn, _params) do
    games =
      DateTime.now!("America/Chicago")
      |> DateTime.to_date()
      |> NHLService.get_scores()

    render(conn, :scores, games: games)
  end
end
