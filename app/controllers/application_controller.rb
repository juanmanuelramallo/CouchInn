class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_filter :set_current_user

  def set_current_user
    Qualification.current_user = current_user
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:nombre, :apellido, :fecnac, :email, :password, :password_confirmation, :remember_me, :avatar) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:avatar, :nombre, :apellido, :fecnac, :genero,:telf, :pais, :ciudad ,:email, :password, :password_confirmation, :current_password) }
    devise_parameter_sanitizer.for(:user) { |u| u.permit(:avatar) }
  end

  def disabled?
    return !user_signed_in?
  end

  def max_cap
    return 8
  end

  def after_sign_in_path_for(resource)
    sign_in_url = new_user_session_url
    if request.referer == sign_in_url
      super
    else
      stored_location_for(resource) || request.referer || root_path
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    request.referrer
  end

  def after_update_path_for(resource)
    stored_location_for(resource) || root_path
  end

end
