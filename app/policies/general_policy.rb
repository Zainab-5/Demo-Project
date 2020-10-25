# frozen_string_literal: true

class GeneralPolicy < ApplicationPolicy
  def new?
    user.type == 'Admin'
  end
  def update?
    user.type == 'Admin'
  end

  def edit?
    user.type == 'Admin'
  end

  def create?
    user.type == 'Admin'
  end

  def destroy?
    user.type == 'Admin'
  end
end
