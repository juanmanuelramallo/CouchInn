class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :couches
  has_many :reservas

end

class AgregarCamposAUser < ActiveRecord::Migration
  def change
    add_column :users, :nombre, :string
    add_column :users, :apellido, :string
    add_column :users, :fecnac, :date
    add_column :users, :telf, :string
    add_column :users, :rol, :integer
  end

end
