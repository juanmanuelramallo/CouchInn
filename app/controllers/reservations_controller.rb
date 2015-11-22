class ReservationsController < ApplicationController
  before_filter :configure_permitted_parameters, if: :devise_controller?
 

  def index
    @reservas = Reservation.where(couch_id: params[:couch_id])
  end

  def show
     #@reservas = Reservation.where(couch_id: params[:couch_id])
  end



  def edit
    @reservatrue = Reservation.find(params[:reservation_id])
    @reservatrue.confirmed = true
    @reservatrue.save
    respond_to do |format|
          if @reservatrue.save
              format.html { redirect_to reservations_path(couch_id: @reservatrue.couch_id), notice: "La reserva fue aceptada." }
              format.json { render :show, status: :created, location:  reservations_path(couch_id: @reservatrue.couch_id) }
          else
              format.html { render :new }
              format.json { render json: reservations_path(couch_id: @reservatrue.couch_id).errors, status: :unprocessable_entity }
          end
      end
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
        if @nuevaReserva.valid?
          if @nuevaReserva.save
              format.html { redirect_to Couch.find(@nuevaReserva.couch_id), notice: "La reserva fue creada correctamente." }
              format.json { render :show, status: :created, location:  Couch.find(@nuevaReserva.couch_id) }
          else
              format.html { render :new }
              format.json { render json: Couch.find(@nuevaReserva.couch_id).errors, status: :unprocessable_entity }
          end
        else
          format.html { render :new }
          format.json { render json: @nuevaReserva.errors, status: :unprocessable_entity }
        end
      end
  end

  def destroy
    @reservad = Reservation.find(params[:id]).destroy
    redirect_to reservations_path(couch_id: @reservad.couch_id)
    
  end


  def update

     #@nuevaReserva = Reservation.find(params[:id])
     #@nuevaReserva.save
    @reservatrue = Reservation.where(couch_id: params[:couch_id])
  end

  def seleccionar
  end

end
