defmodule HockeeWeb.ScoresController do
  use HockeeWeb, :controller

  def scores(conn, _params) do
    render(conn, :scores)
  end
end
