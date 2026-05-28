require "test_helper"

class OwnersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @owner = owners(:one)
  end

  test "should get index" do
    get owners_url
    assert_response :success
  end

  test "should show owner" do
    get owner_url(@owner)
    assert_response :success
  end

  test "should create owner with valid params" do
    assert_difference("Owner.count") do
      post owners_url, params: {
        owner: {
          first_name: "Juan",
          last_name: "Perez",
          email: "juan_#{Time.now.to_i}@test.com", # evita duplicados
          phone: "123456789"
        }
      }
    end

    assert_redirected_to owner_url(Owner.last)
    assert_equal "Owner created successfully", flash[:notice]
  end

  test "should not create owner with invalid params" do
    post owners_url, params: {
      owner: {
        first_name: nil
      }
    }

    assert_response :unprocessable_entity
  end

  test "should update owner" do
    patch owner_url(@owner), params: {
      owner: {
        first_name: "NuevoNombre",
        last_name: @owner.last_name,
        email: "updated_#{@owner.id}@test.com", # evita conflicto de unicidad
        phone: @owner.phone
      }
    }

    assert_redirected_to owner_url(@owner)
  end

  test "should destroy owner" do
    @owner.pets.destroy_all # evita error de FK si no usas dependent: :destroy

    assert_difference("Owner.count", -1) do
      delete owner_url(@owner)
    end

    assert_redirected_to owners_url
  end
end