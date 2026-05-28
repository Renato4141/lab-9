require "test_helper"

class PetTest < ActiveSupport::TestCase
  def valid_pet
    Pet.new(
      name: "Fido",
      species: "dog",
      breed: "Labrador",
      date_of_birth: 2.years.ago.to_date,
      weight: 20.0,
      owner: owners(:one)
    )
  end

  test "valid pet is valid" do
    assert valid_pet.valid?
  end

  test "invalid without name" do
    pet = valid_pet
    pet.name = nil
    assert_not pet.valid?
  end

  test "invalid without species" do
    pet = valid_pet
    pet.species = nil
    assert_not pet.valid?
  end

  test "invalid with unrecognized species" do
    pet = valid_pet
    pet.species = "dragon"
    assert_not pet.valid?
  end

  test "valid species list" do
    %w[dog cat rabbit bird reptile other].each do |sp|
      pet = valid_pet
      pet.species = sp
      assert pet.valid?
    end
  end

  test "invalid without date_of_birth" do
    pet = valid_pet
    pet.date_of_birth = nil
    assert_not pet.valid?
  end

  test "invalid with future date_of_birth" do
    pet = valid_pet
    pet.date_of_birth = 1.day.from_now.to_date
    assert_not pet.valid?
  end

  test "invalid without weight" do
    pet = valid_pet
    pet.weight = nil
    assert_not pet.valid?
  end

  test "invalid with non-positive weight" do
    pet = valid_pet
    pet.weight = 0
    assert_not pet.valid?

    pet.weight = -1
    assert_not pet.valid?
  end

  test "invalid without owner" do
    pet = valid_pet
    pet.owner = nil
    assert_not pet.valid?
  end

  test "name is capitalized before save" do
    pet = valid_pet
    pet.name = "fido"
    pet.save
    assert_equal "Fido", pet.name
  end
end