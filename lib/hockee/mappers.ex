defmodule Hockee.Mappers do
  @moduledoc """
  Mappers used to convert raw NHL API responses to models.  
  """
  alias Hockee.GameTeamStats
  alias Hockee.GameScore

  @doc """
  Maps a single raw NHL game score to a `GameScore`.

  NHL scores API - https://api-web.nhle.com/v1/score/yyyy-mm-dd
  """
  @spec map_to_game_score(map()) :: GameScore.t()
  def map_to_game_score(game_score_map) do
    case game_score_map do
      %{
        "startTimeUTC" => start_time_str,
        "gameState" => game_state,
        "awayTeam" => away_team,
        "homeTeam" => home_team
      } ->
        {_, start_time, _} = DateTime.from_iso8601(start_time_str)

        status =
          case game_state do
            "LIVE" -> :in_progress
            s when s in ["PRE", "FUT"] -> :not_started
            _ -> :finished
          end

        finish_type =
          case game_score_map["gameOutcome"] do
            %{"lastPeriodType" => "REG"} -> :regulation
            %{"lastPeriodType" => "OT"} -> :overtime
            %{"lastPeriodType" => "SO"} -> :shootout
            _ -> nil
          end

        %GameScore{
          start_time: start_time,
          clock: game_score_map["clock"]["timeRemaining"],
          period: game_score_map["period"],
          status: status,
          finish_type: finish_type,
          away_team: %GameTeamStats{
            name: away_team["name"]["default"],
            logo: away_team["logo"],
            goals: away_team["score"],
            sog: away_team["sog"]
          },
          home_team: %GameTeamStats{
            name: home_team["name"]["default"],
            logo: home_team["logo"],
            goals: home_team["score"],
            sog: home_team["sog"]
          }
        }
    end
  end
end
