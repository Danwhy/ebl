defmodule Ebl.DataController do
  use Ebl.Web, :controller

  def index(conn, _params) do
    json conn, %{beers: get_all_beers()}
  end

  def add(conn, params) do
    changeset = Ebl.Beer.changeset %Ebl.Beer{}, params
    Repo.insert! changeset
    json conn, %{beers: get_all_beers()}
  end

  def delete(conn, %{"id" => id}) do
    to_delete = Repo.get!(Ebl.Beer, id)
    Repo.delete! to_delete
    json conn, %{beers: get_all_beers()}
  end

  def get_all_beers() do
    Ebl.Beer
    |> Repo.all
    |> Enum.map(fn(x) -> %{
      name: x.name,
      brand: x.brand,
      beerType: x.type,
      rating: x.rating,
      had: x.had,
      id: x.id
    } end)
  end
end
