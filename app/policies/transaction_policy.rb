# frozen_string_literal: true

class TransactionPolicy < ApplicationPolicy
  def create?
    user.type == 'Buyer' || user.type == 'Admin'
  end
end
