class Searching < ActiveRecord::Base
  belongs_to :user

  validate :capacidad_num
  validate :has_a_field

  def has_a_field
    arr = [self.tipo?, self.capacidad?, self.ubicacion_cont?, self.free_to?, self.free_from?]
    if !arr.include?(true)
      self.errors.add(:base, 'Debes ingresar al menos one parameter de búsqueda')
    end
  end

  def capacidad_num
    if self.capacidad?
      if !(self.capacidad.to_i != 0)
        self.error.add(:capacidad, 'tiene que ser un número')
      end
    end
  end

end
