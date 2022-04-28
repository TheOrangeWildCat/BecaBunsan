defmodule PetClinic.PetClinicService.HealthExpert do
  use Ecto.Schema
  import Ecto.Changeset

  schema "health_experts" do
    field :age, :integer
    field :email, :string
    field :name, :string
    field :sex, Ecto.Enum, values: [:male, :female]
    # field :sex, :string
    field :specialities, :string

    has_many :patients, PetClinic.PetClinicService.Pet, foreign_key: :preferred_expert_id

    timestamps()
  end

  @doc false
  def changeset(health_expert, attrs) do
    health_expert
    |> cast(attrs, [:name, :age, :email, :sex, :specialities])
    |> validate_required([:name, :age, :email, :sex, :specialities])
  end
end
