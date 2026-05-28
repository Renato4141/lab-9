require "test_helper"

class AppointmentTest < ActiveSupport::TestCase

  def valid_appointment
    Appointment.new(
      pet: pets(:one),
      vet: vets(:one),
      date: 1.day.from_now,
      reason: "Checkup",
      status: :scheduled
    )
  end

  test "appointment is valid with all required attributes" do
    appointment = valid_appointment
    assert appointment.valid?
  end

end