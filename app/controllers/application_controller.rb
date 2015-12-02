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


end
