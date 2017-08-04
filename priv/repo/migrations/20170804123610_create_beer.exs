defmodule Ebl.Repo.Migrations.CreateBeer do
  use Ecto.Migration

  def change do
    create table(:beers) do
      add :name, :string
      add :brand, :string
      add :type, :string
      add :rating, :integer
      add :had, :boolean, default: false, null: false

      timestamps()
    end

  end
end
