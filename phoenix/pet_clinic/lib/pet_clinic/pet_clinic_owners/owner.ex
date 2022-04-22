defmodule PetClinic.PetClinicOwners.Owner do
  use Ecto.Schema
  import Ecto.Changeset

  schema "owners" do
    field :age, :integer
    field :email, :string
    field :name, :string
    field :phone_num, :integer
    has_many :pets, PetClinic.PetsClinicService.Pet

    timestamps()
  end

  @doc false
  def changeset(owner, attrs) do
    owner
    |> cast(attrs, [:name, :age, :phone_num, :email])
    |> validate_required([:name, :age, :phone_num, :email])
  end
end
