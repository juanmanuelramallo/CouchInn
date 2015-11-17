class ReservationsController < ApplicationController
  def index
  end

  def show
     @reserva = Reservation.where(user_id:current_user)
  end

  def new
     @nuevaReserva = Reservation.new
     @nuevaReserva.user_id = current_user.id 
     #@nuevaReserva.couch_id = @couch.id
     @nuevaReserva.confirmed = false
     @nuevaReserva.save
  end

  def create
    @nuevaReserva = Reservation.new(params.require(:reservations).permit(:user_id, :couch_id,:confirmed, :start_date, :end_date))
   # @nuevaReserva = Reservation.new(params(:reservations))
   @nuevaReserva.save 
   respond_to do |format|
      if @nuevaReserva.save
         format.html { redirect_to @nuevaReserva, notice: "El reserva fue creado correctamente." }
         format.json { render :show, status: :created, location: @nuevaReserva }
      else
         format.html { render :new }
         format.json { render json: @nuevaReserva.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
  end

  def update
  end
end
