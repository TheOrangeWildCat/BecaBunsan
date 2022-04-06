defmodule PetClinic.PetsClinicExpertsTest do
  use PetClinic.DataCase

  alias PetClinic.PetsClinicExperts

  describe "experts" do
    alias PetClinic.PetsClinicExperts.PetHealthExpert

    import PetClinic.PetsClinicExpertsFixtures

    @invalid_attrs %{age: nil, email: nil, name: nil, specialities: nil}

    test "list_experts/0 returns all experts" do
      pet_health_expert = pet_health_expert_fixture()
      assert PetsClinicExperts.list_experts() == [pet_health_expert]
    end

    test "get_pet_health_expert!/1 returns the pet_health_expert with given id" do
      pet_health_expert = pet_health_expert_fixture()
      assert PetsClinicExperts.get_pet_health_expert!(pet_health_expert.id) == pet_health_expert
    end

    test "create_pet_health_expert/1 with valid data creates a pet_health_expert" do
      valid_attrs = %{age: 42, email: "some email", name: "some name", specialities: "some specialities"}

      assert {:ok, %PetHealthExpert{} = pet_health_expert} = PetsClinicExperts.create_pet_health_expert(valid_attrs)
      assert pet_health_expert.age == 42
      assert pet_health_expert.email == "some email"
      assert pet_health_expert.name == "some name"
      assert pet_health_expert.specialities == "some specialities"
    end

    test "create_pet_health_expert/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PetsClinicExperts.create_pet_health_expert(@invalid_attrs)
    end

    test "update_pet_health_expert/2 with valid data updates the pet_health_expert" do
      pet_health_expert = pet_health_expert_fixture()
      update_attrs = %{age: 43, email: "some updated email", name: "some updated name", specialities: "some updated specialities"}

      assert {:ok, %PetHealthExpert{} = pet_health_expert} = PetsClinicExperts.update_pet_health_expert(pet_health_expert, update_attrs)
      assert pet_health_expert.age == 43
      assert pet_health_expert.email == "some updated email"
      assert pet_health_expert.name == "some updated name"
      assert pet_health_expert.specialities == "some updated specialities"
    end

    test "update_pet_health_expert/2 with invalid data returns error changeset" do
      pet_health_expert = pet_health_expert_fixture()
      assert {:error, %Ecto.Changeset{}} = PetsClinicExperts.update_pet_health_expert(pet_health_expert, @invalid_attrs)
      assert pet_health_expert == PetsClinicExperts.get_pet_health_expert!(pet_health_expert.id)
    end

    test "delete_pet_health_expert/1 deletes the pet_health_expert" do
      pet_health_expert = pet_health_expert_fixture()
      assert {:ok, %PetHealthExpert{}} = PetsClinicExperts.delete_pet_health_expert(pet_health_expert)
      assert_raise Ecto.NoResultsError, fn -> PetsClinicExperts.get_pet_health_expert!(pet_health_expert.id) end
    end

    test "change_pet_health_expert/1 returns a pet_health_expert changeset" do
      pet_health_expert = pet_health_expert_fixture()
      assert %Ecto.Changeset{} = PetsClinicExperts.change_pet_health_expert(pet_health_expert)
    end
  end
end
