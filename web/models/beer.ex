defmodule Ebl.Beer do
  use Ebl.Web, :model

  schema "beers" do
    field :name, :string
    field :brand, :string
    field :type, :string
    field :rating, :integer
    field :had, :boolean, default: false

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :brand, :type, :rating, :had])
    |> validate_required([:name, :brand, :type, :rating, :had])
  end
end
