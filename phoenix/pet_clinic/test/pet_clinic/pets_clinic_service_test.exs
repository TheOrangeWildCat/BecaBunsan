defmodule PetClinic.PetsClinicServiceTest do
  use PetClinic.DataCase

  alias PetClinic.PetsClinicService

  describe "pets" do
    alias PetClinic.PetsClinicService.Pet

    import PetClinic.PetsClinicServiceFixtures

    @invalid_attrs %{age: nil, name: nil, sex: nil, type: nil}

    test "list_pets/0 returns all pets" do
      pet = pet_fixture()
      assert PetsClinicService.list_pets() == [pet]
    end

    test "get_pet!/1 returns the pet with given id" do
      pet = pet_fixture()
      assert PetsClinicService.get_pet!(pet.id) == pet
    end

    test "create_pet/1 with valid data creates a pet" do
      valid_attrs = %{age: 42, name: "some name", sex: "some sex", type: "some type"}

      assert {:ok, %Pet{} = pet} = PetsClinicService.create_pet(valid_attrs)
      assert pet.age == 42
      assert pet.name == "some name"
      assert pet.sex == "some sex"
      assert pet.type == "some type"
    end

    test "create_pet/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PetsClinicService.create_pet(@invalid_attrs)
    end

    test "update_pet/2 with valid data updates the pet" do
      pet = pet_fixture()
      update_attrs = %{age: 43, name: "some updated name", sex: "some updated sex", type: "some updated type"}

      assert {:ok, %Pet{} = pet} = PetsClinicService.update_pet(pet, update_attrs)
      assert pet.age == 43
      assert pet.name == "some updated name"
      assert pet.sex == "some updated sex"
      assert pet.type == "some updated type"
    end

    test "update_pet/2 with invalid data returns error changeset" do
      pet = pet_fixture()
      assert {:error, %Ecto.Changeset{}} = PetsClinicService.update_pet(pet, @invalid_attrs)
      assert pet == PetsClinicService.get_pet!(pet.id)
    end

    test "delete_pet/1 deletes the pet" do
      pet = pet_fixture()
      assert {:ok, %Pet{}} = PetsClinicService.delete_pet(pet)
      assert_raise Ecto.NoResultsError, fn -> PetsClinicService.get_pet!(pet.id) end
    end

    test "change_pet/1 returns a pet changeset" do
      pet = pet_fixture()
      assert %Ecto.Changeset{} = PetsClinicService.change_pet(pet)
    end
  end
end
