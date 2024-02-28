defmodule Hockee.NHLClient do
  @moduledoc """
  A client used to interact with the NHL APIs
  """

  @doc """
  Get the NHL game scores of a given `date`.
  """
  @spec getScores!(Date.t()) :: map()
  def getScores!(date) do
    options =
      [base_url: "https://api-web.nhle.com"]
      |> Keyword.merge(Application.get_env(:hockee, :nhl_client_options, []))

    Req.get!("/v1/score/#{date}", options).body
  end
end
