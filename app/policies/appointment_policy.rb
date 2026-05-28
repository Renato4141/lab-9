class AppointmentPolicy < ApplicationPolicy
  def index?
    admin? || vet? || owner?
  end

  def show?
    admin? || assigned_vet? || owns_appointment?
  end

  def create?
    admin? || vet? || owner?
  end

  def update?
    admin? || assigned_vet? || owns_appointment?
  end

  def destroy?
    admin? || assigned_vet? || owns_appointment?
  end

  def permitted_attributes
    if admin?
      %i[pet_id vet_id date reason status]
    elsif owner?
      %i[vet_id date reason status]
    elsif vet?
      %i[pet_id date reason status]
    else
      []
    end
  end

  class Scope < Scope
    def resolve
      if admin?
        scope.all
      elsif vet?
        scope.where(vet: user.vet)
      elsif owner?
        scope.joins(pet: :owner).where(owners: { user_id: user.id })
      else
        scope.none
      end
    end
  end

  private

  def assigned_vet?
    vet? && record.vet_id == user.vet&.id
  end

  def owns_appointment?
    owner? && record.pet&.owner&.user_id == user.id
  end
end