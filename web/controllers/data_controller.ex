defmodule Ebl.DataController do
  use Ebl.Web, :controller

  def index(conn, _params) do
    beers =
      Ebl.Beer
      |> Repo.all
      |> Enum.map(fn(x) -> %{
        name: x.name,
        brand: x.brand,
        beerType: x.type,
        rating: x.rating,
        had: x.had
      } end)

    json conn, %{beers: beers}
  end

  def add(conn, params) do
    changeset = Ebl.Beer.changeset %Ebl.Beer{}, params
    Repo.insert! changeset
    json conn, %{}
  end
end
