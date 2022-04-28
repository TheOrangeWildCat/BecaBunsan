defmodule PetClinic.PetClinicServiceFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PetClinic.PetClinicService` context.
  """

  @doc """
  Generate a pet.
  """
  def pet_fixture(attrs \\ %{}) do
    {:ok, pet} =
      attrs
      |> Enum.into(%{
        age: 42,
        name: "some name",
        sex: "some sex",
        type: "some type"
      })
      |> PetClinic.PetClinicService.create_pet()

    pet
  end

  @doc """
  Generate a health_expert.
  """
  def health_expert_fixture(attrs \\ %{}) do
    {:ok, health_expert} =
      attrs
      |> Enum.into(%{
        age: 42,
        email: "some email",
        name: "some name",
        sex: "some sex",
        specialities: "some specialities"
      })
      |> PetClinic.PetClinicService.create_health_expert()

    health_expert
  end

  @doc """
  Generate a owner.
  """
  def owner_fixture(attrs \\ %{}) do
    {:ok, owner} =
      attrs
      |> Enum.into(%{
        age: 42,
        email: "some email",
        name: "some name",
        phone_num: "some phone_num"
      })
      |> PetClinic.PetClinicService.create_owner()

    owner
  end
end
