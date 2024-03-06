defmodule Hockee.NHLService do
  alias Hockee.Mappers
  alias Hockee.NHLClient

  def get_scores(date) do
    date
    |> NHLClient.getScores!()
    |> Map.fetch!("games")
    |> Enum.map(&Mappers.map_to_game_score/1)
  end
end
