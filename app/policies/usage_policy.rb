# frozen_string_literal: true

class UsagePolicy < GeneralPolicy
  def create
    user.type == 'Admin'
  end

  def new
    user.type == 'Admin'
  end

  def index
    user.type == 'Admin' || user.type == 'Buyer'
  end
end
