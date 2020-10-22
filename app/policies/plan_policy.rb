class PlanPolicy < ApplicationPolicy
  def update?
    return true if user.type == 'Admin'
  end

  def edit?
    return true if user.type == 'Admin'
  end

  def create?
    return true if user.type == 'Admin'
  end

  def destroy?
    return true if user.type == 'Admin'
  end
end
