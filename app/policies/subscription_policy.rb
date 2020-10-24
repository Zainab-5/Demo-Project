# frozen_string_literal: true

class SubscriptionPolicy < ApplicationPolicy
  def create?
    return true if user.type == 'Buyer'
  end

  def new?
    return true if user.type == 'Buyer'
  end
end
