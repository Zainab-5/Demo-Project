# frozen_string_literal: true

class SubscriptionPolicy < ApplicationPolicy
  def create?
    user.type == 'Buyer'
  end

  def new?
    user.type == 'Buyer'
  end
end
