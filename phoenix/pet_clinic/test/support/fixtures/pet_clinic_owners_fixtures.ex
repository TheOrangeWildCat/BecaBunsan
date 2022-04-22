defmodule PetClinic.PetClinicOwnersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PetClinic.PetClinicOwners` context.
  """

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
        phone_num: 42
      })
      |> PetClinic.PetClinicOwners.create_owner()

    owner
  end
end
