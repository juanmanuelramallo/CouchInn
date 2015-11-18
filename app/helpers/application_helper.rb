module ApplicationHelper
  def tipos_array_search
    tipos_array_search = [['All', 1]]
    aux = Tipoc.all.map { |t| [t.tipo, t.id] }

    return aux
  end
end
