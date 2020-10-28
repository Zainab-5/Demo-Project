# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper ApplicationHelper
  include Pundit
  protect_from_forgery with: :exception, prepend: true
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :image, :type) }
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:name, :email, :password, :image, :type, :password_confirmation, :current_password)
    end
  end

  def after_sign_in_path_for(_resource)
    current_user.type == 'Admin' ? plans_path : subscriptions_path
  end
end
