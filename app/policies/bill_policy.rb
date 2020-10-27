# frozen_string_literal: true

class BillPolicy < ApplicationPolicy
  def billing?
    return true if user.type == 'Admin'
  end
end
