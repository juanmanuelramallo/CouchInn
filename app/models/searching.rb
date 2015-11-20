class Searching < ActiveRecord::Base
  belongs_to :user

  validates :capacidad, numericality: { only_integer: true, allow_blank: true }
  validates :ubicacion_cont, length: { minimum: 4, allow_blank: true }

end
