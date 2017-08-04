defmodule Ebl.DataController do
  use Ebl.Web, :controller

  def index(conn, _params) do
    json conn, Poison.decode!(File.read! "web/elm/data.json")
  end
end
