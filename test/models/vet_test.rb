require "test_helper"

class VetTest < ActiveSupport::TestCase
  def valid_vet
    Vet.new(
      first_name: "Carlos",
      last_name: "Soto",
      email: "carlos@vet.com",
      specialization: "General"
    )
  end

  test "valid vet is valid" do
    assert valid_vet.valid?
  end

  test "invalid without first_name" do
    vet = valid_vet
    vet.first_name = nil
    assert_not vet.valid?
  end

  test "invalid without last_name" do
    vet = valid_vet
    vet.last_name = nil
    assert_not vet.valid?
  end

  test "invalid without email" do
    vet = valid_vet
    vet.email = nil
    assert_not vet.valid?
  end

  test "invalid with bad email format" do
    vet = valid_vet
    vet.email = "not-an-email"
    assert_not vet.valid?
  end

  test "invalid with duplicate email" do
    existing = vets(:one)
    vet = valid_vet
    vet.email = existing.email
    assert_not vet.valid?
  end

  test "invalid without specialization" do
    vet = valid_vet
    vet.specialization = nil
    assert_not vet.valid?
  end

  test "email is normalized before validation" do
    vet = valid_vet
    vet.email = "  CARLOS@VET.COM  "
    vet.valid?
    assert_equal "carlos@vet.com", vet.email
  end
end