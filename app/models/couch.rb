class Couch < ActiveRecord::Base
  belongs_to :usuario
  has_many :reservas
  has_many :fotos

  enum tipo: [:casa, :departamento, :choza, :motorhome]

  #enum tipo: [:casa, :departamento, :choza, :motorhome]

end

