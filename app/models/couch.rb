class Couch < ActiveRecord::Base
  belongs_to :user
  has_many :reservas
  has_many :fotos

  enum tipo: [:Casa, :Departamento, :Choza, :Motorhome]

  #enum tipo: [:casa, :departamento, :choza, :motorhome]

end

