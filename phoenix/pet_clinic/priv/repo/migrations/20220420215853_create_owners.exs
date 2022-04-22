defmodule PetClinic.Repo.Migrations.CreateOwners do
  use Ecto.Migration

  def change do
    create table(:owners) do
      add :name, :string
      add :age, :integer
      add :phone_num, :integer
      add :email, :string

      timestamps()
    end
  end
end
