defmodule PetClinic.Repo.Migrations.CreatePetTypesTable do
  use Ecto.Migration
  import Ecto.Query
  alias PetClinic.Repo
  alias PetClinic.PetClinicService.Pet
  alias PetClinic.PetClinicService.PetType

  def change do
    query_get_pets = "select * from pets;"
    pets = Ecto.Adapters.SQL.query!(Repo,query_get_pets,[]).rows

    query_get_types = "select distinct type from pets;"
    types = Ecto.Adapters.SQL.query!(Repo,query_get_types,[]).rows |> List.flatten


    create table("pet_types") do
      add :name, :string
      timestamps()
    end

    flush() # para poder utilizar lo recien creado mas adelante

    Enum.each(types, fn t ->
      query_insert = "insert into pet_types
                      (name, inserted_at, updated_at)
                      values($1::varchar, current_timestamp(), current_timestamp());"
      Ecto.Adapters.SQL.query!(Repo, query_insert, [t])
    end)

    alter table("pets") do
      remove :type
      add :type_id, references("pet_types")
    end

    flush()
    #una vez asignados los ids en la tabla pet_types
    Enum.each(pets, fn pet ->
      query_type_id =   "select id From pet_types
                        where name = $1::varchar;"
      pet_type_id = Ecto.Adapters.SQL.query!(Repo, query_type_id, [pet])
      query_update = "update pets set type_id = $1::integer where id = $2::integer"
      Ecto.Adapters.SQL.query!(Repo, update, [pet_type_id, List.first(pet)])   # donde petes una lista y el id es el primer elemento
    end)
  end
end
