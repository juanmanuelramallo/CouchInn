module ApplicationHelper
  def tipos_array_search
    aux = Tipoc.all.map { |t| [t.tipo, t.id] }
    return aux
  end
end
