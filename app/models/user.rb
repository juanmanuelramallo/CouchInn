class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable

  validates :fecnac, presence: true
  validate :of_certain_age

  attr_accessor :login

  default_scope -> {order("rol")}

  has_many :couches, dependent: :destroy
  has_many :reservations, dependent: :destroy
  has_many :searchings, dependent: :destroy
  has_many :payments, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :qualifications
  has_many :questions

  has_attached_file :avatar,
    :storage => :dropbox,
    :dropbox_credentials => "#{Rails.root}/config/dropbox.yml",
    styles: { medium: "300x300#", thumb: "100x100#" },
    default_url: ":style/missing-user.jpg",
    :dropbox_options => {
      :path => proc { |style| "#{style}/#{id}_#{avatar.original_filename}" } }

  validates_attachment_size :avatar, less_than: 5.megabytes, allow_blank: true
  validates_attachment_content_type :avatar, content_type: ['image/jpeg', 'image/jpg', 'image/png']

  enum genero: [:Masculino, :Femenino, :Secreto]
  enum rol: [:admin, :normal, :premium]
  after_initialize :set_default_rol, :if => :new_record?
  after_create :send_welcome_message

  def set_default_rol
    self.rol ||= :normal
  end

  def send_welcome_message
    Message.create(user_id: id,
      message:"Bienvenido a CouchInn. Disfruta de todos los couches que se publican a diario en nuestra plataforma! Si tienes dudas ve a la sección ayuda, o no pienses dos veces en escribirnos. ",
      object:"welcome",
      link:"/ayuda"
      )
  end

  def country_name
    if !pais.blank?
      country = ISO3166::Country[pais]
      country.translations[I18n.locale.to_s] || country.name
    else
      return "No especificado"
    end
  end

  # return true if the user se hospedó alguna vez en ese couch
  def one_visit?(couch)
    return reservations.where('couch_id = ? and confirmed = ? and end_date < ?', couch.id, true, Date.today).count > 0
  end

  # retorna las reservas que fueron aceptadas y pasadas de un mismo couch para el usuario
  def was_in(couch)
    return reservations.where('couch_id = ? and confirmed = ? and end_date < ?', couch.id, true, Date.today)
  end

  def can_qualify?(couch)
    # si las veces que estuvo en el couch es mayor que las calificaciones dadas al couch
    if was_in(couch).count > qualifications.where('couch_id = ?', couch.id).count
      return true
    else
      return false
    end
  end

  def has_confirmed_reservation_with?(user)
    #A actual, B user
    couchesB = user.couches

    #reservas confirmadas del usuario actual en couches del usuario B
    res = []

    couchesB.each do |c|
      c.reservations.each do |r|
        if r.end_date > Date.today and r.user.id == id and r.confirmed == true
          return true
        end
      end
    end

    return false

  end

  private



  def of_certain_age
    if self.fecnac
      errors.add(:base, 'Por motivos de seguridad, debes tener al menos 18 años.') if self.fecnac > 18.years.ago
    end
  end

end
