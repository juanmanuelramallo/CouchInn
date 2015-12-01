module DevisePermittedParameters
  extend ActiveSupport::Concern

  included do
    before_filter :configure_permitted_parameters
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :nombre << :apellido << :fecnac << :telf << :rol << :pais << :ciudad
    devise_parameter_sanitizer.for(:account_update) << :nombre << :apellido << :fecnac << :telf << :rol << :pais << :ciudad << :avatar
  end

end

DeviseController.send :include, DevisePermittedParameters
