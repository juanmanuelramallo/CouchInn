module CouchesHelper

  def tipos_array
    tipos_array = Tipoc.all.map { |t| [t.tipo, t.id] }
  end

end
