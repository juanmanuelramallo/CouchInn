class Reservation < ActiveRecord::Base
  belongs_to :user
  
  validate :valid_date
  validates_uniqueness_of :couch_id, :scope => :user_id
  #validates_presence_of :start_date
 #validates :start_date, :end_date, :email, :presence => { message: "No puede dejarse vacío" }


  def valid_date
  if (start_date && end_date) && (end_date < start_date)
    errors.add(:start_date, "debe ser menor a la de finalizacion.")
  end
  if (DateTime.now.to_date > start_date )
    errors.add(:start_date, "debe ser mayor a la actual.")
  end
end

  def start_must_be_before_end_time
    errors.add(:start_date, "debe ir antes de fecha de finalizacion") unless
       start_date > end_date
  end
end
