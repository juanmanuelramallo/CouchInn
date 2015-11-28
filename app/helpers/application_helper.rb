module ApplicationHelper

  def tipos_array_search
    aux = Tipoc.all.map { |t| [t.tipo, t.id] }
    return aux
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def resource_class
    devise_mapping.to
  end

end
