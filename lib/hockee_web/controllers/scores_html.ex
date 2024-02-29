defmodule HockeeWeb.ScoresHTML do
  use HockeeWeb, :html

  defp format_period(period) when period > 3 do
    case period do
      4 -> "OT"
      _ -> "#{period - 3}OT"
    end
  end

  defp format_period(period) do
    case period do
      1 -> "1st"
      2 -> "2nd"
      3 -> "3rd"
      _ -> ""
    end
  end

  defp format_time(start_time) do
    start_time |> DateTime.shift_zone!("America/Chicago") |> Calendar.strftime("%-I:%M %p %Z")
  end

  def game_score(assigns) do
    ~H"""
    <div class="flex w-full max-w-md flex-col rounded-lg border border-zinc-800 px-4 pb-4">
      <div class={[
        "my-2 h-1/3 self-center rounded px-1 text-xs",
        if(@game.status == :in_progress, do: "bg-green-300", else: "bg-gray-300")
      ]}>
        <%= case {@game.status, @game.finish_type} do %>
          <% {:in_progress, _} -> %>
            <%= format_period(@game.period) <> " " <> @game.clock %>
          <% {:finished, :overtime} -> %>
            FINAL/OT
          <% {:finished, :shootout} -> %>
            FINAL/SO
          <% {:finished, _} -> %>
            FINAL
          <% _ -> %>
            <%= format_time(@game.start_time) %>
        <% end %>
      </div>
      <div class="flex h-2/3 items-center">
        <div class="flex w-2/5 items-center">
          <img class="h-12 w-12 pr-1" src={@game.away_team.logo} alt={@game.away_team.name <> " Logo"} />
          <div class="flex flex-col text-white">
            <div>
              <%= @game.away_team.name %>
            </div>
            <div class="text-xs font-medium text-gray-400">
              <%= if @game.status == :not_started do %>
                <%= @game.away_team.record %>
              <% else %>
                SOG: <%= @game.away_team.sog %>
              <% end %>
            </div>
          </div>
        </div>
        <div class="w-1/5 text-center text-white">
          <div :if={@game.status != :not_started}>
            <%= @game.away_team.goals %> – <%= @game.home_team.goals %>
          </div>
        </div>
        <div class="flex w-2/5 items-center justify-end">
          <div class="flex flex-col items-end text-end text-white">
            <%= @game.home_team.name %>
            <div class="text-xs font-medium text-gray-400">
              <%= if @game.status == :not_started do %>
                <%= @game.home_team.record %>
              <% else %>
                SOG: <%= @game.home_team.sog %>
              <% end %>
            </div>
          </div>
          <img class="h-12 w-12 pl-1" src={@game.home_team.logo} alt={@game.home_team.name <> " Logo"} />
        </div>
      </div>
    </div>
    """
  end

  def scores(assigns) do
    ~H"""
    <div>
      <h1 class="text-center text-2xl font-medium text-white">NHL Scores</h1>
      <div class="grid-col-1 grid justify-items-center gap-4 pt-8 md:grid-cols-2">
        <%= for game <- @games do %>
          <.game_score game={game} />
        <% end %>
      </div>
    </div>
    """
  end
end
