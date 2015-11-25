class Reservation < ActiveRecord::Base
  belongs_to :user

  validates :start_date, :presence => true, :on => :create
  validates :end_date, :presence => true, :on => :create

  validate :valid_date
  validate :valid_date_actual
  validate :no_mismo_usuario_misma_fecha
  validate :no_chocan_fechas
  validate :maximo_periodo
  validate :no_eliminado

  validates_uniqueness_of :couch_id, :scope => :user_id

  default_scope {order('created_at')}


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
    if !( end_date.nil? or start_date.nil? )
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
  end

  def no_mismo_usuario_misma_fecha
    if !( end_date.nil? or start_date.nil? )
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

  def maximo_periodo
    if !( end_date.nil? or start_date.nil? )
      max = 30
      if (end_date - start_date) > max
        errors.add(:base, "La reserva no puede ser mayor a #{max} días")
      end
    end
  end

  def no_eliminado
    c = Couch.find(couch_id)
    if c.eliminado
      errors.add(:base, "El couch ha sido eliminado por su dueño y no puede reservarse")
    end
  end

end
