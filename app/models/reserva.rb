class Reserva < ActiveRecord::Base
  belongs_to :couch
  belongs_to :usuario

  enum estado: [:esperando, :aceptada, :cancelada, :denegada]

end
