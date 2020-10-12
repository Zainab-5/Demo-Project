class WelcomePolicy < ApplicationPolicy
  def index?
    return true if user.type == 'Admin'
  end


  private

    def welcome
      record
    end
end
