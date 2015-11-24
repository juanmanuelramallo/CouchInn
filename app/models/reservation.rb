class Reservation < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :start_date
  validates_presence_of :end_date
  validate :valid_date
  validate :valid_date_actual
  validate :no_mismo_usuario_misma_fecha
  validate :no_chocan_fechas



  validates_uniqueness_of :couch_id, :scope => :user_id
  #validates_presence_of :start_date
 #validates :start_date, :end_date, :email, :presence => { message: "No puede dejarse vacío" }


  def valid_date
    if (start_date && end_date) && (end_date < start_date)
      errors.add(:start_date, "debe ser menor a la de finalizacion.")
    end
  end

  def valid_date_actual
    if (start_date != nil)
      if (DateTime.now.to_date > start_date )
        errors.add(:start_date, "debe ser mayor a la actual.")
      end
    end
  end

  def no_chocan_fechas
    #periodo de la reserva solicitada
    rango = start_date..end_date

    #busca todas las reservas confirmadas de este couch para verificar que no se pisen
    r = Reservation.where('couch_id = ? and confirmed = ?', couch_id, true)
    r.each do |res|
      #aux es el rango de fechas obtenido de la tabla de reservas
      aux = res.start_date..res.end_date
      if aux.overlaps?(rango)
        errors.add(:base, "El couch está ocupado en ese período, intenta antes del #{res.start_date.to_formatted_s(:short)}, o después del #{res.end_date.to_formatted_s(:short)}.")
      end
    end
  end

  def no_mismo_usuario_misma_fecha
    #periodo de la reserva solicitada
    rango = start_date..end_date

    #busca todas las reservas confirmadas de este usuario para verificar que no se pisen
    r = Reservation.where('user_id = ? and confirmed = ?', user_id, true)
    r.each do |res|
      #aux es el rango de fechas obtenido de la tabla de reservas
      aux = res.start_date..res.end_date
      if aux.overlaps?(rango)
        errors.add(:base, "Ya tienes una reserva confirmada para esas fechas, intenta antes del #{res.start_date.to_formatted_s(:short)}, o después del #{res.end_date.to_formatted_s(:short)}.")
      end
    end
  end

end
