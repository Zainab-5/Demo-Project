class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception, prepend: true

  before_action :authenticate_user!, :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :image, :type ) }
  end

  def after_sign_in_path_for(resource)
    current_user.type == "Admin"? plans_path : subscriptions_path
  end
end
