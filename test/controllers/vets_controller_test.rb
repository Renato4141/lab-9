require "test_helper"

class VetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @vet = vets(:one)
  end

  test "should get index" do
    get vets_url
    assert_response :success
  end

  test "should show vet" do
    get vet_url(@vet)
    assert_response :success
  end

  test "should create vet with valid params" do
    assert_difference("Vet.count") do
      post vets_url, params: {
        vet: {
          first_name: "Carlos",
          last_name: "Soto",
          email: "nuevo@vet.com",
          specialization: "General"
        }
      }
    end

    assert_redirected_to vet_url(Vet.last)
    assert_equal "Vet created successfully", flash[:notice]
  end

  test "should not create vet with invalid params" do
    post vets_url, params: {
      vet: { first_name: nil }
    }

    assert_response :unprocessable_entity
  end

  test "should update vet" do
    patch vet_url(@vet), params: {
      vet: {
        first_name: "Nuevo",
        last_name: @vet.last_name,
        email: "updated_#{@vet.id}@vet.com",
        specialization: @vet.specialization
      }
    }

    assert_redirected_to vet_url(@vet)
  end

  test "should destroy vet" do
    # Crear vet sin dependencias para evitar FK error
    vet = Vet.create!(
      first_name: "Temp",
      last_name: "Delete",
      email: "temp_#{Time.now.to_i}@vet.com",
      specialization: "General"
    )

    assert_difference("Vet.count", -1) do
      delete vet_url(vet)
    end

    assert_redirected_to vets_url
  end
end