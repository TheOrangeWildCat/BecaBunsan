defmodule PetClinic.Repo.Migrations.CreatePetTypesTable do
  use Ecto.Migration
  import Ecto.Query
  alias PetClinic.Repo
  alias PetClinic.PetClinicService.Pet
  alias PetClinic.PetClinicService.PetType

  def change do
    pets = Repo.all(Pet)
    types = Repo.all(from p in Pet, select: [p.type], distinct: true) |> List.flatten()

    create table("pet_types") do
      add :name, :string
      timestamps()
    end

    flush() # para poder utilizar lo recien creado mas adelante

    Enum.each(types, fn t ->
      Repo.insert(%PetType{name: t})
    end)

    alter table("pets") do
      remove :type
      add :type_id, references("pet_types")
    end

    flush()

    Enum.each(pets, fn pet ->
      %PetType{id: pet_type_id} = Repo.get_by(PetType, name: pet.type)
      update = "update pets set type_id = $1::integer where id = $2::integer"
      Ecto.Adapters.SQL.query!(Repo, update, [pet_type_id, pet.id])
    end)
  end
end
