class Couch < ActiveRecord::Base
  belongs_to :user

  has_many :reservations, dependent: :destroy
  has_many :qualifications, dependent: :destroy
  has_many :questions, dependent: :destroy

  after_initialize :init

  def init
    self.eliminado ||= false
  end

  def is_owner?(user)
    return user_id == user.id
  end

  def self.get_owner(couch_id)
    return Couch.find(couch_id).user_id
  end

  def get_owner
    return User.find(user_id)
  end

  def has_confirmed_reservation(user)
    return Reservation.where('user_id = ? and couch_id = ? and confirmed = ? and end_date > ?',user.id, id, true, Date.today).count
  end

  has_attached_file :photo,
    :storage => :dropbox,
    :dropbox_credentials => "#{Rails.root}/config/dropbox.yml",
    styles: { original: "4000x4000>", large:"2000x2000>" ,medium: "800x800>" ,small: "300x300>" },
    default_url: ":style/missing.jpeg",
    :dropbox_options => {
      :path => proc { |style| "#{style}/#{id}_#{photo.original_filename}" } }

  validates_attachment_size :photo, less_than: 5.megabytes, allow_blank: true
  validates_attachment_content_type :photo, content_type: ['image/jpeg', 'image/jpg', 'image/png']

  def get_tipo
    if Tipoc.find(tipo).blank?
      return "Couch"
    else
      return Tipoc.find(tipo).tipo
    end
  end

  def is_free?
    hoy = Date.today..Date.today
    reservations.where('confirmed = ?', true).each do |r|
      rango = r.start_date..r.end_date
      if rango.overlaps?(hoy)
        return false
      end
    end
    return true
  end

  def get_not_available_dates
    dates = [] #fechas de reservas confirmadas
    if reservations.blank?
      dates << "Ninguna. Todas las fechas están disponibles"
      return dates
    else
      reservations.where('confirmed = ? and end_date > ?', true, Date.today).each_with_index do |r, i|
        dates << "No.#{i+1} -- del #{I18n.l r.start_date, format: :short} al #{I18n.l r.end_date, format: :short}."
      end

      return dates if !dates.blank?

      dates << "Ninguna. Todas las fechas están disponibles"
      return dates
    end
  end


end

