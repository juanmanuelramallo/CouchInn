class ReservationsController < ApplicationController
  before_filter :configure_permitted_parameters, if: :devise_controller?
  def index
  end

  def show
     @reserva = Reservation.where(user_id:current_user)
  end

  def new
     @nuevaReserva = Reservation.new(couch_id: params[:couch_id])
     #@nuevaReserva.user_id = current_user.id    
     #@nuevaReserva.couch_id = params[:couch_id]

     #session[:reservation_couch_id] = @nuevaReserva.couch_id      
     #@nuevaReserva.confirmed = false
     #@nuevaReserva.save
  end

  def create
      @nuevaReserva = Reservation.new(params.require(:reservation).permit(:couch_id,:confirmed, :start_date, :end_date))
      @nuevaReserva.user_id = current_user.id    
      @nuevaReserva.confirmed = false
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
     @nuevaReserva = Reservation.find(params[:id])
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
end
