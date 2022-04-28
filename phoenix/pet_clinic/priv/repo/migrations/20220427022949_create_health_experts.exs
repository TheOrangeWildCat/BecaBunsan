defmodule PetClinic.Repo.Migrations.CreateHealthExperts do
  use Ecto.Migration

  def change do
    create table(:health_experts) do
      add :name, :string
      add :age, :integer
      add :email, :string
      add :sex, :string
      add :specialities, :string

      timestamps()
    end
  end
end
