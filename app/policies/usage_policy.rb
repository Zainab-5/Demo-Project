# frozen_string_literal: true

class UsagePolicy < ApplicationPolicy
  def create?
    return true if user.type == 'Admin'
  end

  def new?
    return true if user.type == 'Admin'
  end

  def edit?
    return true if user.type == 'Admin'
  end

  def destroy?
    return true if user.type == 'Admin'
  end
end
