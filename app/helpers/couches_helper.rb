module CouchesHelper

  def tipos_array
    tipos_array = Tipoc.all.map { |t| [t.tipo, t.id] }
  end

  def tipo_couch_index(couch)
    if Tipoc.where(:id => couch.tipo).blank?
      tipo_couch_index = "Couch"
    else
      tipo_couch_index = Tipoc.find(couch.tipo).tipo
    end
  end

end
