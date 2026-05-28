class TreatmentPolicy < ApplicationPolicy
  def create?
    admin? || manages_appointment?
  end

  def update?
    admin? || manages_appointment?
  end

  def destroy?
    admin? || manages_appointment?
  end

  def permitted_attributes
    if admin?
      %i[name medication dosage clinical_notes administered_at appointment_id]
    elsif vet?
      %i[name medication dosage clinical_notes administered_at]
    else
      []
    end
  end

  private

  def manages_appointment?
    vet? && record.appointment&.vet_id == user.vet&.id
  end
end