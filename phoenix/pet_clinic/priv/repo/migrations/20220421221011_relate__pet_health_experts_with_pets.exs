defmodule PetClinic.Repo.Migrations.Relate_PetHealthExpertsWithPets do
  use Ecto.Migration

  def change do
    alter table("pets") do
      add :pet_health_expert, references("experts")
    end
  end
end
