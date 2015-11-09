class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :login

  has_many :couches
  has_many :reservas

  enum genero: [:masculino, :femenino, :prefiero_no_especificar]
  enum rol: [:admin, :normal, :premium]
  after_initialize :set_default_rol, :if => :new_record?

    def set_default_rol
      self.rol ||= :normal
    end

end
