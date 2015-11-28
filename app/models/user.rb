class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable

  validates :fecnac, presence: true
  validate :of_certain_age

  attr_accessor :login

  default_scope -> {order("rol")}

  has_many :couches
  has_many :reservations
  has_many :searchings
  has_many :payments
  has_many :messages

  has_attached_file :avatar,
    :storage => :dropbox,
    :dropbox_credentials => "#{Rails.root}/config/dropbox.yml",
    styles: { medium: "300x300>", thumb: "100x100>" },
    default_url: ":style/missing-user.jpg",
    :dropbox_options => {
      :path => proc { |style| "#{style}/#{id}_#{avatar.original_filename}" } }

  validates_attachment_size :avatar, less_than: 5.megabytes
  validates_attachment_content_type :avatar, content_type: ['image/jpeg', 'image/jpg', 'image/png']

  enum genero: [:Masculino, :Femenino, :Prefiero_no_especificar]
  enum rol: [:admin, :normal, :premium]
  after_initialize :set_default_rol, :if => :new_record?

    def set_default_rol
      self.rol ||= :normal
    end

  private

  def of_certain_age
    if self.fecnac
      errors.add(:base, 'Por motivos de seguridad, debes tener al menos 18 años.') if self.fecnac > 18.years.ago
    end
  end

end
