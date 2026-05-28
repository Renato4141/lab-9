require "test_helper"

class TreatmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @appointment = appointments(:one)
    @treatment = @appointment.treatments.first || treatments(:one)
  end

  test "should get new" do
    get new_appointment_treatment_url(@appointment)
    assert_response :success
  end

  test "should create treatment with valid params" do
    assert_difference("Treatment.count") do
      post appointment_treatments_url(@appointment), params: {
        treatment: {
          name: "Antibiotic",
          medication: "Amoxicillin",
          dosage: "2x daily",
          administered_at: Time.current
        }
      }
    end

    assert_redirected_to appointment_url(@appointment)
    assert_equal "Treatment created successfully", flash[:notice]
  end

  test "should not create treatment with invalid params" do
    post appointment_treatments_url(@appointment), params: {
      treatment: { name: nil }
    }

    assert_response :unprocessable_entity
  end

  test "should update treatment" do
    patch appointment_treatment_url(@appointment, @treatment), params: {
      treatment: { name: "Updated Treatment" }
    }

    assert_redirected_to appointment_url(@appointment)
  end

  test "should destroy treatment" do
    assert_difference("Treatment.count", -1) do
      delete appointment_treatment_url(@appointment, @treatment)
    end

    assert_redirected_to appointment_url(@appointment)
  end
end