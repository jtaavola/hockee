defmodule Hockee.GameTeamStats do
  @moduledoc """
  The game stats of a team. 
  """

  @enforce_keys [:name, :logo]
  defstruct [
    :name,
    :goals,
    :sog,
    :logo
  ]

  @type t() :: %__MODULE__{
          name: String.t(),
          goals: non_neg_integer() | nil,
          sog: non_neg_integer() | nil,
          logo: String.t()
        }
end

defmodule Hockee.GameScore do
  @moduledoc """
  The score of a hockey game.
  """
  alias Hockee.GameTeamStats

  @enforce_keys [
    :start_time,
    :status,
    :away_team,
    :home_team
  ]
  defstruct [
    :start_time,
    :clock,
    :period,
    :status,
    :finish_type,
    :away_team,
    :home_team
  ]

  @type t() :: %__MODULE__{
          start_time: DateTime.t(),
          clock: String.t() | nil,
          period: non_neg_integer() | nil,
          status: :not_started | :in_progress | :finished,
          finish_type: :regulation | :overtime | :shootout | nil,
          away_team: GameTeamStats.t(),
          home_team: GameTeamStats.t()
        }
end
