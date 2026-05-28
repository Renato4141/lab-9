class OwnerPolicy < ApplicationPolicy
  def index?
    admin? || vet?
  end

  def show?
    admin? || vet? || owns_record?
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
    %i[first_name last_name email phone address]
  end

  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      elsif user.vet?
        scope.all
      elsif user.owner?
        scope.where(user: user)
      else
        scope.none
      end
    end
  end

  private

  def owns_record?
    owner? && record.user_id == user.id
  end
end