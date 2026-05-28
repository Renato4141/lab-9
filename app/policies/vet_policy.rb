class VetPolicy < ApplicationPolicy
  def index?
    admin? || vet? || owner?
  end

  def show?
    admin? || vet? || owner?
  end

  def create?
    admin?
  end

  def update?
    admin? || owns_record?
  end

  def destroy?
    admin?
  end

  def permitted_attributes
    %i[first_name last_name email phone specialization]
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end

  private

  def owns_record?
    vet? && record.user_id == user.id
  end
end