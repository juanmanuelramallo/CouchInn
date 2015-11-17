module CouchesHelper

  def options_for_tipo
    tipos = Tipoc.pluck(:tipo)
    return tipos
  end

end
