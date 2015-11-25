class MensajesController < ApplicationController
  def index

  end

  def show
    @reservasok = Reservation.where(user_id: current_user.id)
  end

  def new
    @mensaje = Mensaje.new(user_id: params[:user_id], couch_id: params[:couch_id])
    @mensaje.message = "Se le ha aceptado la solicitud de reserva"
    @mensaje.save
  end

  def destroy
  end

  def update
  end

  def create
  end
end
