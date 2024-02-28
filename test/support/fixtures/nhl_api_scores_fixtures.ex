defmodule NHLApiScoresFixtures do
  # TODO: can I remove fields from the map? for example, removing the clock field.

  @doc """
  Creates a NHL API game score fixture. Use `attrs` to override the default, and `drops` to drop 
  keys from the default.
  """
  @spec game_score_fixture(map(), list()) :: map()
  def game_score_fixture(attrs \\ %{}, drops \\ []) do
    %{
      "id" => 2_023_020_925,
      "season" => 20_232_024,
      "gameType" => 2,
      "gameDate" => "2024-02-26",
      "venue" => %{
        "default" => "Rogers Place"
      },
      "startTimeUTC" => "2024-02-27T02:30:00Z",
      "easternUTCOffset" => "-05:00",
      "venueUTCOffset" => "-07:00",
      "tvBroadcasts" => [
        %{
          "id" => 281,
          "market" => "N",
          "countryCode" => "CA",
          "network" => "TVAS",
          "sequenceNumber" => 32
        },
        %{
          "id" => 284,
          "market" => "N",
          "countryCode" => "CA",
          "network" => "SN1",
          "sequenceNumber" => 23
        },
        %{
          "id" => 289,
          "market" => "N",
          "countryCode" => "CA",
          "network" => "SNW",
          "sequenceNumber" => 31
        },
        %{
          "id" => 355,
          "market" => "A",
          "countryCode" => "US",
          "network" => "BSW",
          "sequenceNumber" => 57
        }
      ],
      "gameState" => "LIVE",
      "gameScheduleState" => "OK",
      "awayTeam" => %{
        "id" => 26,
        "name" => %{
          "default" => "Kings"
        },
        "abbrev" => "LAK",
        "score" => 2,
        "sog" => 26,
        "logo" => "https://assets.nhle.com/logos/nhl/svg/LAK_light.svg"
      },
      "homeTeam" => %{
        "id" => 22,
        "name" => %{
          "default" => "Oilers"
        },
        "abbrev" => "EDM",
        "score" => 2,
        "sog" => 21,
        "logo" => "https://assets.nhle.com/logos/nhl/svg/EDM_light.svg"
      },
      "gameCenterLink" => "/gamecenter/lak-vs-edm/2024/02/26/2023020925",
      "clock" => %{
        "timeRemaining" => "12:25",
        "secondsRemaining" => 745,
        "running" => false,
        "inIntermission" => true
      },
      "neutralSite" => false,
      "venueTimezone" => "America/Edmonton",
      "period" => 2,
      "periodDescriptor" => %{
        "number" => 2,
        "periodType" => "REG"
      },
      "goals" => [
        %{
          "period" => 1,
          "periodDescriptor" => %{
            "number" => 1,
            "periodType" => "REG"
          },
          "timeInPeriod" => "06:45",
          "playerId" => 8_479_675,
          "name" => %{
            "default" => "T. Moore"
          },
          "mugshot" => "https://assets.nhle.com/mugs/nhl/20232024/LAK/8479675.png",
          "teamAbbrev" => "LAK",
          "goalsToDate" => 22,
          "awayScore" => 1,
          "homeScore" => 0,
          "strength" => "EV",
          "highlightClip" => 6_347_717_801_112,
          "highlightClipFr" => 6_347_716_997_112
        },
        %{
          "period" => 1,
          "periodDescriptor" => %{
            "number" => 1,
            "periodType" => "REG"
          },
          "timeInPeriod" => "19:36",
          "playerId" => 8_475_786,
          "name" => %{
            "default" => "Z. Hyman"
          },
          "mugshot" => "https://assets.nhle.com/mugs/nhl/20232024/EDM/8475786.png",
          "teamAbbrev" => "EDM",
          "goalsToDate" => 38,
          "awayScore" => 1,
          "homeScore" => 1,
          "strength" => "EV",
          "highlightClip" => 6_347_717_618_112,
          "highlightClipFr" => 6_347_716_072_112
        },
        %{
          "period" => 2,
          "periodDescriptor" => %{
            "number" => 2,
            "periodType" => "REG"
          },
          "timeInPeriod" => "07:34",
          "playerId" => 8_482_155,
          "name" => %{
            "default" => "A. Laferriere"
          },
          "mugshot" => "https://assets.nhle.com/mugs/nhl/20232024/LAK/8482155.png",
          "teamAbbrev" => "LAK",
          "goalsToDate" => 8,
          "awayScore" => 2,
          "homeScore" => 1,
          "strength" => "EV",
          "highlightClip" => 6_347_719_424_112,
          "highlightClipFr" => 6_347_717_859_112
        },
        %{
          "period" => 2,
          "periodDescriptor" => %{
            "number" => 2,
            "periodType" => "REG"
          },
          "timeInPeriod" => "15:56",
          "playerId" => 8_477_934,
          "name" => %{
            "default" => "L. Draisaitl"
          },
          "mugshot" => "https://assets.nhle.com/mugs/nhl/20232024/EDM/8477934.png",
          "teamAbbrev" => "EDM",
          "goalsToDate" => 29,
          "awayScore" => 2,
          "homeScore" => 2,
          "strength" => "PP",
          "highlightClip" => 6_347_719_834_112,
          "highlightClipFr" => 6_347_718_378_112
        }
      ]
    }
    |> Map.merge(attrs)
    |> Map.drop(drops)
  end
end
