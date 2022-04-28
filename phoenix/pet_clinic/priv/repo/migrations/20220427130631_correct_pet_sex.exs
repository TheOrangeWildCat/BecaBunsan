defmodule PetClinic.Repo.Migrations.CorrectPetSex do
  use Ecto.Migration
  alias PetClinic.Repo
  def change do
    query = "update pets set sex = lower(sex)" #pasar las letras a minusculas
    Ecto.Adapters.SQL.query!(Repo, query, [])  #paso el repo, el query, y las variables, si obtiene un error truena el programa (!)

    query = "update pets set sex = 'female' where sex not in ('male', 'female')"
    Ecto.Adapters.SQL.query!(Repo, query, [])
  end
end
