require "test_helper"

class PetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pet = pets(:one)
    @owner = owners(:one)
  end

  test "should get index" do
    get pets_url
    assert_response :success
  end

  test "should show pet" do
    get pet_url(@pet)
    assert_response :success
  end

  test "should create pet with valid params" do
    assert_difference("Pet.count") do
      post pets_url, params: {
        pet: {
          name: "Fido",
          species: "dog",
          breed: "Labrador",
          date_of_birth: 2.years.ago.to_date,
          weight: 10,
          owner_id: @owner.id
        }
      }
    end

    assert_redirected_to pet_url(Pet.last)
  end

  test "should not create pet with invalid params" do
    post pets_url, params: { pet: { name: nil } }
    assert_response :unprocessable_entity
  end

  test "should update pet" do
    patch pet_url(@pet), params: {
      pet: {
        name: "NuevoNombre",
        species: "dog",
        breed: "Labrador",
        date_of_birth: 2.years.ago.to_date,
        weight: 12,
        owner_id: @owner.id
      }
    }

    assert_redirected_to pet_url(@pet)
  end

  test "should destroy pet" do
    @pet.appointments.destroy_all   # evitar FK error

    assert_difference("Pet.count", -1) do
      delete pet_url(@pet)
    end

    assert_redirected_to pets_url
  end
end