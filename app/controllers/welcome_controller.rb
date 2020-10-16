class WelcomeController < ApplicationController
  def index

  end

  def show_profile

  end

  def all_subscriptions
    @user = current_user
  end
end
