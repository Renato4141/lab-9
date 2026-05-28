class PetPolicy < ApplicationPolicy
  def index?
    admin? || vet? || owner?
  end

  def show?
    admin? || vet? || owns_pet?
  end

  def create?
    admin? || owner?
  end

  def update?
    admin? || owns_pet?
  end

  def destroy?
    admin? || owns_pet?
  end

  def permitted_attributes
    if admin?
      %i[name species breed date_of_birth weight owner_id photo]
    else
      %i[name species breed date_of_birth weight photo]
    end
  end

  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      elsif user.vet?
        scope.all
      elsif user.owner?
        scope.joins(:owner).where(owners: { user_id: user.id })
      else
        scope.none
      end
    end
  end

  private

  def owns_pet?
    owner? && record.owner&.user_id == user.id
  end
end