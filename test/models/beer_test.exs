defmodule Ebl.BeerTest do
  use Ebl.ModelCase

  alias Ebl.Beer

  @valid_attrs %{brand: "some content", had: true, name: "some content", rating: 42, type: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Beer.changeset(%Beer{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Beer.changeset(%Beer{}, @invalid_attrs)
    refute changeset.valid?
  end
end
