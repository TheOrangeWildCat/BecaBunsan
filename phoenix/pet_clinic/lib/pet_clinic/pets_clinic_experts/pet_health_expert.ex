defmodule PetClinic.PetsClinicExperts.PetHealthExpert do
  use Ecto.Schema
  import Ecto.Changeset

  schema "experts" do
    field :age, :integer
    field :email, :string
    field :name, :string
    field :specialities, :string

    has_many :patients, PetClinic.PetsClinicService.Pet

    timestamps()
  end

  @doc false
  def changeset(pet_health_expert, attrs) do
    pet_health_expert
    |> cast(attrs, [:name, :age, :email, :specialities])
    |> validate_required([:name, :age, :email, :specialities])
  end
end
