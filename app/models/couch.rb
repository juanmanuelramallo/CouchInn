class Couch < ActiveRecord::Base
  belongs_to :user
  has_many :reservas
  has_many :fotos
end

