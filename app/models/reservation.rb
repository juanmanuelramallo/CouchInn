class Reservation < ActiveRecord::Base
  belongs_to :user
  validate :valid_date

  def valid_date
  if (start_date && end_date) && (end_date < start_date)
    errors.add(:start_date, :message => "La fecha de inicio debe ser menor a la de finalizacion.")
  end
  end

  def start_must_be_before_end_time
    errors.add(:start_date, "debe ir antes de fecha de finalizacion") unless
       start_date > end_date
  end 
end
